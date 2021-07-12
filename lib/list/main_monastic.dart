import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMonastic extends StatelessWidget {
  final List<DocumentSnapshot> m_list;
  final int index;

  MainMonastic({Key key, this.m_list, this.index}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("Monastic").where("UID",isEqualTo: m_list[index]["UID"].toString()).get(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
              ),
            );
          }else{
            return  Column(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue,Color(0xFF76FF03)]),
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
                          minWidth: 260,
                          child: FlatButton(
                              onPressed: () async {
                                Navigator.pushNamed(context, '/press_monastic');
                                Map <String, dynamic> data = {
                                    "UID": document["UID"],
                                };
                                await FirebaseFirestore.instance.collection("User").doc(( _auth.currentUser).uid).collection("MonaList").doc(( _auth.currentUser).uid).set(data);
                              },
                              child: Column(
                                children: [
                                  Text(document["Name"], style: GoogleFonts.noticiaText(fontSize: 17,color: Colors.white)),
                                  Text(document["CID"], style: GoogleFonts.noticiaText(fontSize: 17,color: Colors.white)),
                                ],
                              )
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.blue,
                              size: 40,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient:LinearGradient(
                                              colors: [
                                                Colors.blue,
                                                Color(0xFF76FF03),
                                              ]
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text('Warning!', style: GoogleFonts.ptSerif(fontSize: 20,)),
                                              SizedBox(height: 5,),
                                              Text(
                                                "Are you sure that you want to delete " + document["Name"] + " monastic card",
                                                style: GoogleFonts.ptSerif(fontSize: 20,),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  FlatButton(
                                                    onPressed: () async{
                                                      Navigator.pushNamed(context, '/scanned_list');
                                                      await FirebaseFirestore.instance.collection("User").doc(( _auth.currentUser).uid).collection("ScanList").doc(document["UID"]).delete();
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 50),
                                                      child: new Text('Yes',style: GoogleFonts.anton(fontSize: 20),),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(context, '/scanned_list');
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 50),
                                                      child: new Text('No',style: GoogleFonts.anton(fontSize: 20),),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }
        }
    );
  }
}