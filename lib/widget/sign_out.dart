import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neumorphic/neumorphic.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;
dynamic image;

getData() async{
  String a = _auth.currentUser.uid;
  DocumentSnapshot result = await FirebaseFirestore.instance.collection("UserData").doc(a).get();
  name = googleSignIn.currentUser.displayName;
  email = googleSignIn.currentUser.email;
  image = Image.network(googleSignIn.currentUser.photoUrl);

  if(!result.exists){
    Map <String, dynamic> data={
      'name':name,
      'uid': a,
      'email': email,
      'role':"user",
      'imageUrl': googleSignIn.currentUser.photoUrl,
    };
    await FirebaseFirestore.instance.collection('UserData').doc(a).set(data);
  }
  return null;
}


Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  getData();

  if (user != null) {
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    //Store the retrieved data
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

   //  Only taking the first part of the name, i.e., First Name
   // if (name.contains(" ")) {
    //  name = name.substring(0, name.indexOf(" "));
   // }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

//super admin page

class SuperAdminHomePage extends StatefulWidget {
  @override
  _SuperAdminHomePageState createState() => _SuperAdminHomePageState();
}

class _SuperAdminHomePageState extends State<SuperAdminHomePage> {
  Stream<QuerySnapshot> requestCountBusiness() {
    return FirebaseFirestore.instance.collection("Business").snapshots();
  }
  Stream<QuerySnapshot> requestCountCivilServant() {
    return FirebaseFirestore.instance.collection("CivilServant").snapshots();
  }
  Stream<QuerySnapshot> requestCountMonastic() {
    return FirebaseFirestore.instance.collection("Monastic").snapshots();
  }
  Stream<QuerySnapshot> requestCountCollegeStudent() {
    return FirebaseFirestore.instance.collection("CollegeStudent").snapshots();
  }
  Stream<QuerySnapshot> requestCountReport() {
    return FirebaseFirestore.instance.collectionGroup("Report").snapshots();
  }
  Stream<QuerySnapshot> requestCountScanList() {
    return FirebaseFirestore.instance.collectionGroup("ScanList").snapshots();
  }
  Stream<QuerySnapshot> requestCountUser() {
    return FirebaseFirestore.instance.collection("UserData").snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392869),
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Positioned(
                child: NeuCard(
                  curveType: CurveType.concave,
                  bevel: 5,
                  decoration:  NeumorphicDecoration(
                    color: Color(0xFF4DD0E1),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  ),
                  child: Container(
                    // color: Colors.blue,
                    height:150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.purple,Colors.red]),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    ),

                  ),
                ),
              ),

              Positioned(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8,left: 10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          imageUrl,
                        ),
                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      children: [
                        Text(name,style: GoogleFonts.noticiaText(fontSize: 20, color: Colors.white)),
                        Text(email,style: GoogleFonts.noticiaText(fontSize: 15, color: Colors.white)),
                      ],
                    )
                  ],
                ),
                // child: image,width: 350,height: 200,
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text("LinCa Statistics Board",style: GoogleFonts.noticiaText(fontSize: 25, color: Color(0xFF4DD0E1),shadows: <Shadow>[
            Shadow(
              offset: Offset(10.0, 10.0),
              blurRadius: 3.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            Shadow(
              offset: Offset(10.0, 10.0),
              blurRadius: 8.0,
              color: Color.fromARGB(125, 0, 0, 255),
            ),
          ],)),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: GridView(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                children: <Widget>[
                  FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Card(
                      elevation: 10,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            StreamBuilder<QuerySnapshot>(
                                stream: requestCountBusiness(),
                                builder: (context, snapshot){

                                  if (snapshot.hasData){

                                    return Text(snapshot?.data.size.toString() ?? '0',style:  GoogleFonts.goblinOne(fontSize: 70, color: Color(0xFF4DD0E1)));
                                  }
                                  return Center(child: CircularProgressIndicator(),);
                                }
                            ),
                            Text('Business', style: GoogleFonts.noticiaText(fontSize: 20, color: Color(0xFF4DD0E1)),),
                          ],
                        ),
                      ),
                    ),
                    back: Card(
                      elevation: 10,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            StreamBuilder<QuerySnapshot>(
                                stream: requestCountCivilServant(),
                                builder: (context, snapshot){

                                  if (snapshot.hasData){

                                    return Text(snapshot?.data.size.toString() ?? '0',style:   GoogleFonts.goblinOne(fontSize: 70, color: Color(0xFF4DD0E1)));
                                  }
                                  return Center(child: CircularProgressIndicator(),);
                                }
                            ),
                            Text('Civil Servant', style: GoogleFonts.noticiaText(fontSize: 20, color: Color(0xFF4DD0E1)),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Card(
                      elevation: 10,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            StreamBuilder<QuerySnapshot>(
                                stream: requestCountCollegeStudent(),
                                builder: (context, snapshot){

                                  if (snapshot.hasData){

                                    return Text(snapshot?.data.size.toString() ?? '0',style:  GoogleFonts.goblinOne(fontSize: 70, color: Color(0xFF4DD0E1)));
                                  }
                                  return Center(child: CircularProgressIndicator(),);
                                }
                            ),
                            Text('Student', style: GoogleFonts.noticiaText(fontSize: 20, color: Color(0xFF4DD0E1)),),
                          ],
                        ),
                      ),
                    ),
                    back: Card(
                      elevation: 10,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            StreamBuilder<QuerySnapshot>(
                                stream: requestCountMonastic(),
                                builder: (context, snapshot){

                                  if (snapshot.hasData){

                                    return Text(snapshot?.data.size.toString() ?? '0',style:   GoogleFonts.goblinOne(fontSize: 70, color: Color(0xFF4DD0E1)));
                                  }
                                  return Center(child: CircularProgressIndicator(),);
                                }
                            ),
                            Text('Monastic', style: GoogleFonts.noticiaText(fontSize: 20, color: Color(0xFF4DD0E1)),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Card(
                      elevation: 10,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            StreamBuilder<QuerySnapshot>(
                                stream: requestCountReport(),
                                builder: (context, snapshot){

                                  if (snapshot.hasData){

                                    return Text(snapshot?.data.size.toString() ?? '0',style:  GoogleFonts.goblinOne(fontSize: 70, color: Color(0xFF4DD0E1)));
                                  }
                                  return Center(child: CircularProgressIndicator(),);
                                }
                            ),
                            Text('Report', style: GoogleFonts.noticiaText(fontSize: 20, color: Color(0xFF4DD0E1)),),
                          ],
                        ),
                      ),
                    ),
                    back: Card(
                      elevation: 10,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            StreamBuilder<QuerySnapshot>(
                                stream: requestCountScanList(),
                                builder: (context, snapshot){

                                  if (snapshot.hasData){

                                    return Text(snapshot?.data.size.toString() ?? '0',style:   GoogleFonts.goblinOne(fontSize: 70, color: Color(0xFF4DD0E1)));
                                  }
                                  return Center(child: CircularProgressIndicator(),);
                                }
                            ),
                            Text('Scan List', style: GoogleFonts.noticiaText(fontSize: 20, color: Color(0xFF4DD0E1)),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Card(
                      elevation: 10,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            StreamBuilder<QuerySnapshot>(
                                stream: requestCountUser(),
                                builder: (context, snapshot){

                                  if (snapshot.hasData){

                                    return Text(snapshot?.data.size.toString() ?? '0',style:  GoogleFonts.goblinOne(fontSize: 70, color: Color(0xFF4DD0E1)));
                                  }
                                  return Center(child: CircularProgressIndicator(),);
                                }
                            ),
                            Text('Users', style: GoogleFonts.noticiaText(fontSize: 20, color: Color(0xFF4DD0E1)),),
                          ],
                        ),
                      ),
                    ),
                    // back: Card(
                    //   elevation: 10,
                    //   child: Center(
                    //     child: Column(
                    //       children: [
                    //         SizedBox(height: 40,),
                    //         StreamBuilder<QuerySnapshot>(
                    //             stream: requestCountCivilServant(),
                    //             builder: (context, snapshot){
                    //
                    //               if (snapshot.hasData){
                    //
                    //                 return Text(snapshot?.data.size.toString() ?? '0',style:   GoogleFonts.goblinOne(fontSize: 70, color: Color(0xFF4DD0E1)));
                    //               }
                    //               return Center(child: CircularProgressIndicator(),);
                    //             }
                    //         ),
                    //         Text('Civil Servant', style: GoogleFonts.noticiaText(fontSize: 20, color: Color(0xFF4DD0E1)),),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

