import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linca/admin/admin_monastic.dart';

class AdminMainMonastic extends StatefulWidget {
  @override
  _AdminMainMonasticState createState() => _AdminMainMonasticState();
}

class _AdminMainMonasticState extends State<AdminMainMonastic> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392869),
      body:  Container(
        child: Row(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Admin")
                    .doc((_auth.currentUser).uid)
                    .collection("MonaList").snapshots(),
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
                          padding: const EdgeInsets.only(top: 100),
                          child: Column(
                            children: [
                              AdminMonastic(m_list: userDocument,index: index),
                            ],
                          ),
                        );
                      });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
