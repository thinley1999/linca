import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/admin/admin_main_business.dart';
import 'package:linca/admin/admin_main_civil_servant.dart';
import 'package:linca/admin/admin_main_monastic.dart';
import 'package:linca/admin/admin_main_student.dart';

class BusinessCards extends StatefulWidget {
  @override
  _BusinessCardsState createState() => _BusinessCardsState();
}

class _BusinessCardsState extends State<BusinessCards> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }
  var db;
  void initState() {
    db = FirebaseFirestore.instance.collectionGroup("Business").snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392869),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff392869),
      ),
      body: StreamBuilder(
        stream: db,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData ?
          ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var userDocument = snapshot.data.docs;
            return  Container(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.purple,Colors.red]),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/business.jpg'),
                        radius: 30,
                        backgroundColor: Colors.transparent,
                      ),
                      ButtonTheme(
                        minWidth: 250,
                        child: FlatButton(
                            onPressed: () async {
                              Map <String, dynamic> data = {
                                "UID": userDocument[index].data()["UID"],
                              };
                              await FirebaseFirestore.instance.collection("Admin").doc((_auth.currentUser).uid).
                              collection("BusiList").doc((_auth.currentUser).uid).set(data);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => AdminMainBusiness(),
                                  )
                              );
                            },
                            child: Column(
                              children: [
                                Text(userDocument[index].data()["Name"], style: GoogleFonts.noticiaText(fontSize: 17, color: Colors.white)),
                                Text(userDocument[index].data()["CID"], style: GoogleFonts.noticiaText(fontSize: 17, color: Colors.white)),
                              ],
                            )),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                          ),
                          iconSize: 30,
                          color: Colors.white,
                          onPressed: () async {
                            await FirebaseFirestore.instance.collection("Business").doc(userDocument[index].data()["UID"]).delete();
                          }
                      ),
                    ],
                  ),
                ),
              );
            },
          ) : Container();
        }
      ),
    );
  }
}

class CivilServantCards extends StatefulWidget {
  @override
  _CivilServantCardsState createState() => _CivilServantCardsState();
}

class _CivilServantCardsState extends State<CivilServantCards> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }
  var db;
  void initState() {
    db = FirebaseFirestore.instance.collectionGroup("CivilServant").snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392869),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff392869),
      ),
      body: StreamBuilder(
          stream: db,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData ?
            ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var userDocument = snapshot.data.docs;
                return  Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.purple,Colors.red]),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/civilservant.jpg'),
                          radius: 30,
                          backgroundColor: Colors.transparent,
                        ),
                        ButtonTheme(
                          minWidth: 250 ,
                          child: FlatButton(
                              onPressed: () async {
                                Map <String, dynamic> data = {
                                  "UID": userDocument[index].data()["UID"],
                                };
                                await FirebaseFirestore.instance.collection("Admin").doc((_auth.currentUser).uid).
                                collection("CiviList").doc((_auth.currentUser).uid).set(data);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => AdminMainCivilServant(),
                                    )
                                );
                              },
                              child: Column(
                                children: [
                                  Text(userDocument[index].data()["Name"], style: GoogleFonts.noticiaText(fontSize: 17, color: Colors.white)),
                                  Text(userDocument[index].data()["CID"], style: GoogleFonts.noticiaText(fontSize: 17, color: Colors.white)),
                                ],
                              )),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            iconSize: 30,
                            color: Colors.white,
                            onPressed: () async {
                              await FirebaseFirestore.instance.collection("CivilServant").doc(userDocument[index].data()["UID"]).delete();
                            }
                        ),
                      ],
                    ),
                  ),
                );
              },
            ) : Container();
          }
      ),
    );
  }
}

class MonasticCards extends StatefulWidget {
  @override
  _MonasticCardsState createState() => _MonasticCardsState();
}

class _MonasticCardsState extends State<MonasticCards> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }
  var db;
  void initState() {
    db = FirebaseFirestore.instance.collectionGroup("Monastic").snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392869),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff392869),
      ),
      body: StreamBuilder(
          stream: db,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData ?
            ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var userDocument = snapshot.data.docs;
                return  Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.purple,Colors.red]),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/monk.jpg'),
                          radius: 30,
                          backgroundColor: Colors.transparent,
                        ),
                        ButtonTheme(
                          minWidth: 250 ,
                          child: FlatButton(
                              onPressed: () async{
                                Map <String, dynamic> data = {
                                  "UID": userDocument[index].data()["UID"],
                                };
                                await FirebaseFirestore.instance.collection("Admin").doc((_auth.currentUser).uid).
                                collection("MonaList").doc((_auth.currentUser).uid).set(data);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => AdminMainMonastic(),
                                    )
                                );
                              },
                              child: Column(
                                children: [
                                  Text(userDocument[index].data()["Name"], style: GoogleFonts.noticiaText(fontSize: 17, color: Colors.white)),
                                  Text(userDocument[index].data()["CID"], style: GoogleFonts.noticiaText(fontSize: 17, color: Colors.white)),
                                ],
                              )),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            iconSize: 30,
                            color: Colors.white,
                            onPressed: () async {
                              await FirebaseFirestore.instance.collection("Monastic").doc(userDocument[index].data()["UID"]).delete();
                            }
                        ),
                      ],
                    ),
                  ),
                );
              },
            ) : Container();
          }
      ),
    );
  }
}

class StudentCards extends StatefulWidget {
  @override
  _StudentCardsState createState() => _StudentCardsState();
}

class _StudentCardsState extends State<StudentCards> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }
  var db;
  void initState() {
    db = FirebaseFirestore.instance.collectionGroup("CollegeStudent").snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392869),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff392869),
      ),
      body: StreamBuilder(
          stream: db,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData ?
            ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var userDocument = snapshot.data.docs;
                return  Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.purple,Colors.red]),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/student.jpg'),
                          radius: 30,
                          backgroundColor: Colors.transparent,
                        ),
                        ButtonTheme(
                          minWidth: 250 ,
                          child: FlatButton(
                              onPressed: () async{
                                Map <String, dynamic> data = {
                                  "UID": userDocument[index].data()["UID"],
                                };
                                await FirebaseFirestore.instance.collection("Admin").doc((_auth.currentUser).uid).
                                collection("CollList").doc((_auth.currentUser).uid).set(data);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => AdminMainStudent(),
                                    )
                                );
                              },
                              child: Column(
                                children: [
                                  Text(userDocument[index].data()["Name"], style: GoogleFonts.noticiaText(fontSize: 17, color: Colors.white)),
                                  Text(userDocument[index].data()["CID"], style: GoogleFonts.noticiaText(fontSize: 17, color: Colors.white)),
                                ],
                              )),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            iconSize: 30,
                            color: Colors.white,
                            onPressed: () async {
                              await FirebaseFirestore.instance.collection("CollegeStudent").doc(userDocument[index].data()["UID"]).delete();
                            }
                        ),
                      ],
                    ),
                  ),
                );
              },
            ) : Container();
          }
      ),
    );
  }
}



