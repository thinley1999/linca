import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linca/widget/sign_out.dart';

class CollegeStudent extends StatefulWidget {
  @override
  _CollegeStudentState createState() => _CollegeStudentState();
  final String student;
  const CollegeStudent({Key key, this.student}) : super(key : key);

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}

class _CollegeStudentState extends State<CollegeStudent> {
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
          future: DefaultAssetBundle.of(context).loadString("assets/college_student.json"),
          builder: (context, snapshot){
            var myDoc = json.decode(snapshot.data.toString());

            return new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return (myDoc[index]['id'] == widget.student) ?
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
                                borderRadius: BorderRadius.circular(10.0),
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
                          controller: TextEditingController(text: myDoc[index]["college"]),
                          decoration: InputDecoration(
                              labelText: 'College Name',
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
                          controller: TextEditingController(text: myDoc[index]["year"]),
                          decoration: InputDecoration(
                              labelText: 'Year',
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
                            "College Name":  myDoc[index]["college"],
                            "Year":  myDoc[index]["year"],
                            "Phone":  myDoc[index]["phone"],
                            "Blood Group": myDoc[index]["blood group"],
                            "UID": "Coll" + (_auth.currentUser).uid,
                            "Email": email,
                          };
                          await FirebaseFirestore.instance.collection("CollegeStudent").doc("Coll" + (_auth.currentUser).uid).set(data);

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
