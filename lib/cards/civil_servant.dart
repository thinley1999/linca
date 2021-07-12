import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linca/widget/sign_out.dart';

class CivilServant extends StatefulWidget {
  @override
  _CivilServantState createState() => _CivilServantState();
  final String civilServant;
  const CivilServant({Key key, this.civilServant, }) : super(key : key);

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}

class _CivilServantState extends State<CivilServant> {
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
      body: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString("assets/civil_servant.json"),
          builder: (context, snapshot){
            var myDoc = json.decode(snapshot.data.toString());

            return new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return (myDoc[index]['id'] == widget.civilServant) ?
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10,),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.blue, Color(0xFF76FF03)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(text: myDoc[index]["name"]),
                          decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              enabledBorder: InputBorder.none
                          ) ,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.blue, Color(0xFF76FF03)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(text: myDoc[index]["cid"]),
                          decoration: InputDecoration(
                              labelText: 'CID',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              enabledBorder: InputBorder.none
                          ) ,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.blue, Color(0xFF76FF03)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(text: myDoc[index]["organization name"]),
                          decoration: InputDecoration(
                              labelText: 'Organization Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              enabledBorder: InputBorder.none
                          ) ,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.blue, Color(0xFF76FF03)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(text: myDoc[index]["organization address"]),
                          decoration: InputDecoration(
                              labelText: 'Organization Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              enabledBorder: InputBorder.none
                          ) ,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.blue, Color(0xFF76FF03)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(text: myDoc[index]["phone"]),
                          decoration: InputDecoration(
                              labelText: 'Phone',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              enabledBorder: InputBorder.none
                          ) ,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.blue, Color(0xFF76FF03)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(text: myDoc[index]["blood group"]),
                          decoration: InputDecoration(
                              labelText: 'Blood Group',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              enabledBorder: InputBorder.none
                          ) ,
                        ),
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        child: Text('Submit',style: GoogleFonts.ptSerif(fontSize: 15),),
                        onPressed: () async {
                          Map <String, dynamic> data = {
                            "Name":  myDoc[index]["name"],
                            "CID":  myDoc[index]["cid"],
                            "Organization Name":  myDoc[index]["organization name"],
                            "Organization address":  myDoc[index]["organization address"],
                            "Phone":  myDoc[index]["phone"],
                            "Blood Group": myDoc[index]["blood group"],
                            "UID": "Civi" + (_auth.currentUser).uid,
                            "Email": email,
                          };
                          await FirebaseFirestore.instance.collection("CivilServant").doc("Civi" + (_auth.currentUser).uid).set(data);

                          Navigator.pushNamed(context, '/home');
                        },
                      ),
                    ],
                  ),
                ) : Center();
              },
              itemCount: myDoc == null ? 0 : myDoc.length,
            );
          }
      ),
    );
  }
}
