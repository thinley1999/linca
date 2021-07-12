import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linca/list/fetch_civil_servant.dart';
import 'package:linca/main_drawer.dart';

class PressCivilServant extends StatefulWidget {
  @override
  _PressCivilServantState createState() => _PressCivilServantState();
}

class _PressCivilServantState extends State<PressCivilServant> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      appBar: AppBar(
        backgroundColor: Color(0xFF212121),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      drawer: MainDrawer(),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("User")
            .doc((_auth.currentUser).uid)
            .collection("CiviList").snapshots(),
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
                return Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      FetchCivilServant( c_list: userDocument,index: index),
                    ],
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
