import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/main_drawer.dart';
import 'package:linca/pages/custom_painter.dart';
import 'package:neumorphic/neumorphic.dart';

class UserBusiness extends StatefulWidget {
  @override

  _UserBusinessState createState() => _UserBusinessState();
}

class _UserBusinessState extends State<UserBusiness> {
  var db;
  void initState() {
    db = FirebaseFirestore.instance.collection("Business").doc("Busi" + (_auth.currentUser).uid).snapshots();
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }
  bool _allow = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      appBar: AppBar(
        backgroundColor: Color(0xFF212121),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      drawer: MainDrawer(),
      body: new StreamBuilder(
          stream: db,
          builder: (context, snapshot) {
            if (!snapshot.hasData || !snapshot.data.exists) {
              return Container(
                child: Center(
                  child: new GradientText(
                    text: 'You have not created a particular card.',
                    colors: <Color>[
                      Colors.blue,
                      Color(0xFF76FF03),
                    ],
                    style: GoogleFonts.courgette(fontSize: 30,letterSpacing: 1),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            var userDocument = snapshot.data;
            return Container(
              padding: EdgeInsets.only(bottom: 30),
              child: Center(
                child: NeuCard(
                  curveType: CurveType.concave,
                  bevel: 5,
                  decoration:  NeumorphicDecoration(
                    color: Color(0xFF4DD0E1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    height: height*0.7,
                    width: width*0.8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue,Color(0xFF76FF03)]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CustomPaint(
                        size: Size(width,height),
                        painter: CardCustomPainter(),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: ShaderMask(
                                child: Image.asset(
                                  'assets/img1.png',
                                  width: width*0.8,
                                ),
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [Colors.blue.withOpacity(0.9), Color(0xFF76FF03).withOpacity(0.8)],
                                    // stops: [0.0,0.5],
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.srcATop,
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Image.asset(
                                'assets/divider.png',
                                width: width*0.7,
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(height: 30,),
                                Center(
                                  child: Image.asset('assets/logo2.png',width: width*0.4,),
                                ),
                                SizedBox(height: 10,),
                                Text('Link Making Card',style: GoogleFonts.greatVibes(fontSize: 30, color: Colors.white,letterSpacing: 1)),
                                SizedBox(height: 100,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person,
                                            size: 30,
                                          ),
                                          SizedBox(width: 20,),
                                          new Text(
                                            userDocument["Name"],
                                            style: GoogleFonts.ptSerif(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Icon(Icons.person_pin,
                                            size: 30,
                                          ),
                                          SizedBox(width: 20,),
                                          new Text(
                                            userDocument["CID"],
                                            style: GoogleFonts.ptSerif(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Icon(Icons.work,
                                            size: 25,
                                          ),
                                          SizedBox(width: 20,),
                                          new Text(
                                            userDocument["Designation"],
                                            style: GoogleFonts.ptSerif(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Icon(Icons.home,
                                            size: 30,
                                          ),
                                          SizedBox(width: 20,),
                                          new Text(
                                            userDocument["Company Name"],
                                            style: GoogleFonts.ptSerif(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Icon(Icons.mail,
                                            size: 25,
                                          ),
                                          SizedBox(width: 20,),
                                          new Text(
                                            userDocument["Email"],
                                            style: GoogleFonts.ptSerif(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Icon(Icons.phone,
                                            size: 30,
                                          ),
                                          SizedBox(width: 20,),
                                          new Text(
                                            userDocument["Phone"],
                                            style: GoogleFonts.ptSerif(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                           // color: Colors.blue,
                                            size: 30,
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
                                                              "Are you sure that you want to delete your business card.",
                                                              style: GoogleFonts.ptSerif(fontSize: 20,),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            SizedBox(height: 20,),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                WillPopScope(
                                                                  onWillPop: () {
                                                                    return Future.value(_allow); // if true allow back else block it
                                                                  },
                                                                  child: FlatButton(
                                                                    onPressed: () async{
                                                                      await FirebaseFirestore.instance.collection("Business").doc("Busi" + (_auth.currentUser).uid).delete();
                                                                      Navigator.pushNamed(context, '/home');
                                                                    },
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(bottom: 50),
                                                                      child: new Text('Yes',style: GoogleFonts.anton(fontSize: 20),),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: 10,),
                                                                WillPopScope(
                                                                  onWillPop: () {
                                                                    return Future.value(_allow); // if true allow back else block it
                                                                  },
                                                                  child: FlatButton(
                                                                    onPressed: () {
                                                                      Navigator.pushNamed(context, '/home');
                                                                    },
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(bottom: 50),
                                                                      child: new Text('No',style: GoogleFonts.anton(fontSize: 20),),
                                                                    ),
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
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
