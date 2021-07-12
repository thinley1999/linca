import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/pages/custom_painter.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:linca/admin/utils.dart';

class FetchCivilServant extends StatefulWidget {
  final List<DocumentSnapshot> c_list;
  final int index;

  const FetchCivilServant({Key key, this.c_list, this.index}) : super(key: key);

  @override
  _FetchCivilServantState createState() => _FetchCivilServantState();
}

class _FetchCivilServantState extends State<FetchCivilServant> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }
  TextEditingController civilServantController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("CivilServant").where("UID",isEqualTo: widget.c_list[widget.index]["UID"].toString()).get(),
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
          }else {
            return  Column(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Center(
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
                                  SizedBox(height: 80,),
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
                                              document["Name"],
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
                                              document["CID"],
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
                                              document["Organization Name"],
                                              style: GoogleFonts.ptSerif(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Icon(Icons.home_work,
                                              size: 30,
                                            ),
                                            SizedBox(width: 20,),
                                            new Text(
                                              document["Organization address"],
                                              style: GoogleFonts.ptSerif(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            mailButton(
                                              text: 'Open Email',
                                              onClicked: () => Utils.openEmail(
                                                  toEmail: document["Email"],
                                                  subject: 'LinCa',
                                                  body: 'Hello...'
                                              ),
                                            ),
                                            new Text(
                                              document["Email"],
                                              style: GoogleFonts.ptSerif(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            buildButton(
                                              text: 'Open Call',
                                              onClicked: () =>
                                                  Utils.openPhoneCall(phoneNumber:  document["Phone"]),
                                            ),
                                            new Text(
                                              document["Phone"],
                                              style: GoogleFonts.ptSerif(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.report,size: 30,),
                                            onPressed:  () async {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (BuildContext context) {
                                                    return Padding(
                                                      padding: const EdgeInsets.only(bottom: 10),
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
                                                          child: Container(
                                                            padding: EdgeInsets.all(10),
                                                            height: 330,
                                                            child: Form(
                                                              key: _formKey,
                                                              child: Column(
                                                                children: [
                                                                  TextFormField(
                                                                    controller: TextEditingController(text: document["Name"]),
                                                                    decoration: InputDecoration(
                                                                      labelText: 'Name',
                                                                      border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      labelStyle: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                                                        borderRadius: BorderRadius.circular(5),
                                                                      ),
                                                                    ) ,
                                                                  ),
                                                                  SizedBox(height: 10,),
                                                                  TextFormField(
                                                                    controller: TextEditingController(text: document["Email"]),
                                                                    decoration: InputDecoration(
                                                                      labelText: 'Email',
                                                                      border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      labelStyle: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                                                        borderRadius: BorderRadius.circular(10),
                                                                      ),
                                                                    ) ,
                                                                  ),
                                                                  SizedBox(height: 10,),
                                                                  TextFormField(
                                                                    controller: civilServantController,
                                                                    decoration: InputDecoration(
                                                                      labelText: 'Description',
                                                                      border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                      ),
                                                                      labelStyle: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                                                        borderRadius: BorderRadius.circular(5),
                                                                      ),
                                                                    ) ,
                                                                    validator: (value) {
                                                                      if (value == null || value.isEmpty) {
                                                                        return 'Description is requires';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                  SizedBox(height: 30,),
                                                                  Container(
                                                                    height: 40,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.blue,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: Colors.white,
                                                                            blurRadius: 10,
                                                                          ),
                                                                        ]),
                                                                    child: FlatButton(
                                                                      onPressed: () async {
                                                                        Map <String, dynamic> data = {
                                                                          "Name":  document["Name"],
                                                                          "Email": document["Email"],
                                                                          "Description": civilServantController.text,
                                                                          "UID": (_auth.currentUser).uid,
                                                                          "SID": document["UID"],
                                                                        };
                                                                        await FirebaseFirestore.instance.collection("User").doc((_auth.currentUser).uid).collection("Report").doc(document["UID"]).set(data);

                                                                        if(!_formKey.currentState.validate()){
                                                                          return ;
                                                                        }
                                                                        Navigator.of(context).pop();
                                                                        Fluttertoast.showToast(
                                                                            msg: "Report Successful",
                                                                            toastLength: Toast.LENGTH_SHORT,
                                                                            gravity: ToastGravity.CENTER,
                                                                            timeInSecForIosWeb: 1,
                                                                            backgroundColor: Colors.red,
                                                                            textColor: Colors.white,
                                                                            fontSize: 16.0
                                                                        );
                                                                      },
                                                                      child: Text('Submit',style: GoogleFonts.ptSerif(fontSize: 15),),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                              );
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
                );
              }).toList(),
            );
          }
        }
    );
  }
  Widget buildButton({
    @required String text,
    @required VoidCallback onClicked,
  }) =>
      IconButton(
        icon: Icon(
          Icons.phone,
          color: Colors.black,
          size: 30,
        ),
        onPressed: onClicked,
      );

  Widget mailButton({
    @required String text,
    @required VoidCallback onClicked,
  }) =>
      IconButton(
        icon: Icon(
          Icons.mail,
          color: Colors.black,
          size: 30,
        ),
        onPressed: onClicked,
      );
}
