import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/forms/business_form.dart';
import 'package:linca/forms/civil_servant_form.dart';
import 'package:linca/forms/college_student_form.dart';
import 'package:linca/forms/monastic_form.dart';
import 'package:linca/pages/home_page.dart';
import 'package:linca/profile.dart';
import 'package:linca/tutorial/tutorial.dart';
import 'package:linca/widget/sign_in.dart';
import 'package:linca/widget/sign_out.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool _allow = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }

  var db;
  final keyOne = GlobalKey();
  void initState()  {
    db = FirebaseFirestore.instance.collection("UserData").doc((_auth.currentUser).uid).snapshots();
    super.initState();
  }

  alert(){
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                 // ListTile(title: Text("Alert")),
                  Container(
                    padding: EdgeInsets.only(top: 40),
                      child: ListTile(
                          title: Text(
                              "You have already created a particular card. Delete existing one to create new card",
                            style: GoogleFonts.caveat(fontSize: 25,),
                          ),
                      ),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: new Text('Okay',style: GoogleFonts.anton(fontSize: 20),),
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color(0xFF212121),
        //other styles
      ),
      child: Drawer(
        child: Column(
          children: <Widget> [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue,Color(0xFF76FF03)]),
              ),
              child: Center(
                child: Column(
                  children: <Widget> [
                    Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.only(top: 30),
                      child:  CircleAvatar(
                        backgroundImage: AssetImage('assets/logo.png'),
                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                      ),
                    Text(
                      'Link Making Card',
                      style: GoogleFonts.greatVibes(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0,),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue,size: 30,),
              title: Text(
                'Profile',
                style: GoogleFonts.noticiaText(fontSize: 23,color: Colors.blue),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(
                     builder: (context) => Profile(),
                   ));
              },
            ),
            Divider(
              thickness: 1,
              color: Colors.blue,
            ),
            ListTile(
              leading: Icon(Icons.business, color: Colors.blue,size: 30,),
              title: Text(
                'Business',
                style: GoogleFonts.noticiaText(fontSize: 23,color: Colors.blue),
              ),
              onTap: () {
                FirebaseFirestore.instance.collection("Business").doc("Busi" + (_auth.currentUser).uid).get().then((doc) {
                  if(doc.exists){
                    alert();
                  } else {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => BusinessForm(),
                        ));
                  }
                });
              },
            ),
            Divider(
              thickness: 1,
              color: Colors.blue,
            ),
            ListTile(
              leading: Icon(Icons.work, color: Colors.blue,size: 30,),
              title: Text(
                'Civil Servant',
                style: GoogleFonts.noticiaText(fontSize: 23,color: Colors.blue),
              ),
              onTap: () {
                FirebaseFirestore.instance.collection("CivilServant").doc("Civi" + (_auth.currentUser).uid).get().then((doc) {
                  if(doc.exists){
                   alert();
                  } else {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => CivilServantForm(),
                        ));
                  }
                });
              },
            ),
            Divider(
              thickness: 1,
              color: Colors.blue,
            ),
            ListTile(
              leading: Icon(Icons.people, color: Colors.blue,size: 30,),
              title: Text(
                'College Student',
                style: GoogleFonts.noticiaText(fontSize: 23,color: Colors.blue),
              ),
              onTap: () {
                FirebaseFirestore.instance.collection("CollegeStudent").doc("Coll" + (_auth.currentUser).uid).get().then((doc) {
                  if(doc.exists){
                    alert();
                  } else {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => CollegeStudentForm(),
                        ));
                  }
                });
              },
            ),
            Divider(
              thickness: 1,
              color: Colors.blue,
            ),
            ListTile(
              leading: Icon(Icons.person_pin, color: Colors.blue,size: 30,),
              title: Text(
                'Monastic',
                style: GoogleFonts.noticiaText(fontSize: 23,color: Colors.blue),
              ),
              onTap: () {
                FirebaseFirestore.instance.collection("Monastic").doc("Mona" + (_auth.currentUser).uid).get().then((doc) {
                  if(doc.exists){
                    alert();
                  } else {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => MonasticForm(),
                        ));
                  }
                });
              },
            ),
            Divider(
              thickness: 1,
              color: Colors.blueAccent,
            ),
            ListTile(
              leading: Icon(Icons.video_collection, color: Colors.blueAccent,size: 30,),
              title: Text(
                'Tutorial',
                style: GoogleFonts.noticiaText(fontSize: 23,color: Colors.blue),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => Tutorial(),
                    ));
              },
            ),
            Divider(
              thickness: 1,
              color: Colors.blueAccent,
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.blueAccent,size: 30,),
              title: Text(
                'Log Out',
                style: GoogleFonts.noticiaText(fontSize: 23,color: Colors.blue),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return WillPopScope(
                        onWillPop: () {
                          return Future.value(_allow); // if true allow back else block it
                        },
                        child: Dialog(
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: ListTile(
                                    title: Text(
                                      "Thank you for using LinCa. You have Logged Out Successfully",
                                      style: GoogleFonts.ptSerif(fontSize: 25,),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  onPressed:() {
                                    signOutGoogle();
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 50),
                                    child: new Text('Close',style: GoogleFonts.anton(fontSize: 20),),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

}
