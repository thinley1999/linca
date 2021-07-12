import 'package:flutter/material.dart';
import 'package:linca/list/main_business.dart';
import 'package:linca/list/main_monastic.dart';
import 'package:linca/list/main_student.dart';
import 'package:linca/list/mian_civil_servant.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linca/main_drawer.dart';

class ScannedList extends StatefulWidget {
  @override
  _ScannedListState createState() => _ScannedListState();
}

class _ScannedListState extends State<ScannedList> {
  bool _allow = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(_allow); // if true allow back else block it
      },
      child: Scaffold(
        backgroundColor: Color(0xFF212121),
        appBar: AppBar(
          backgroundColor: Color(0xFF212121),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue),
        ),
        drawer: MainDrawer(),
        body:  Container(
          child: Row(
            children: [
              Expanded(
                child: SwipeDetector(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("User")
                        .doc((_auth.currentUser).uid)
                        .collection("ScanList")
                        .orderBy("Time", descending: true)
                        .snapshots(),
                    builder: (context,snapshot){
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState){
                        case ConnectionState.waiting:
                          return  Container(
                            height: 200.0,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
                            ),
                          );
                        default:
                          return ListView.builder(itemCount:snapshot.data.docs.length,itemBuilder: (_,index){
                            List<DocumentSnapshot> userDocument = snapshot.data.docs;
                            return Column(
                              children: [
                                MainBusiness(b_list: userDocument,index: index),
                                MainCivilServant(c_list: userDocument,index: index),
                                MainMonastic(m_list: userDocument,index: index),
                                MainStudent(s_list: userDocument,index: index),
                              ],
                            );
                          });
                      }
                    },
                  ),
                  onSwipeRight: () {
                    setState(() {
                      Navigator.pushNamed(context, '/home');
                    });
                  },
                  onSwipeLeft: () {
                    setState(() {
                      Navigator.pushNamed(context, '/scanner');
                    });
                  },
        swipeConfiguration: SwipeConfiguration(
            verticalSwipeMinVelocity: 100.0,
            verticalSwipeMinDisplacement: 50.0,
            verticalSwipeMaxWidthThreshold:100.0,
            horizontalSwipeMaxHeightThreshold: 50.0,
            horizontalSwipeMinDisplacement:50.0,
            horizontalSwipeMinVelocity: 200.0),
      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
