import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/pages/admin_custom_painter.dart';
import 'package:neumorphic/neumorphic.dart';

class AdminStudent extends StatelessWidget {
  final List<DocumentSnapshot> s_list;
  final int index;

  AdminStudent({Key key, this.s_list, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("CollegeStudent").where("UID",isEqualTo: s_list[index]["UID"].toString()).get(),
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
                        gradient: LinearGradient(colors: [Colors.purple, Colors.red]),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CustomPaint(
                          size: Size(width,height),
                          painter: AdminCardCustomPainter(),
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
                                      colors: [Color(0xFF4DD0E1).withOpacity(0.5), Colors.purple.withOpacity(0.6)],
                                      // stops: [0.0,0.5],
                                    ).createShader(bounds);
                                  },
                                  blendMode: BlendMode.srcATop,
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: ShaderMask(
                                  child: Image.asset(
                                    'assets/divider.png',
                                    width: width*0.7,
                                  ),
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                      colors: [Color(0xFF4DD0E1).withOpacity(0.5), Colors.purple.withOpacity(0.6)],
                                      // stops: [0.0,0.5],
                                    ).createShader(bounds);
                                  },
                                  blendMode: BlendMode.srcATop,
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 30,),
                                  Center(
                                    child: Image.asset('assets/logo2.png',width: width*0.4,),
                                  ),
                                  SizedBox(height: 10,),
                                  Text('Link Making Card',style: GoogleFonts.greatVibes(fontSize: 30, color: Color(0xFF4DD0E1),letterSpacing: 1)),
                                  SizedBox(height: 100,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.person,
                                                size: 30,
                                                color: Color(0xFF4DD0E1)
                                            ),
                                            SizedBox(width: 20,),
                                            new Text(
                                              document["Name"],
                                              style: GoogleFonts.ptSerif(fontSize: 20,color: Color(0xFF4DD0E1)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Icon(Icons.person_pin,
                                                size: 30,
                                                color: Color(0xFF4DD0E1)
                                            ),
                                            SizedBox(width: 20,),
                                            new Text(
                                              document["CID"],
                                              style: GoogleFonts.ptSerif(fontSize: 20,color: Color(0xFF4DD0E1)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Icon(Icons.home,
                                                size: 25,
                                                color: Color(0xFF4DD0E1)
                                            ),
                                            SizedBox(width: 20,),
                                            new Text(
                                              document["College Name"],
                                              style: GoogleFonts.ptSerif(fontSize: 20,color: Color(0xFF4DD0E1)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Icon(Icons.book,
                                                size: 30,
                                                color: Color(0xFF4DD0E1)
                                            ),
                                            SizedBox(width: 20,),
                                            new Text(
                                              document["Year"],
                                              style: GoogleFonts.ptSerif(fontSize: 20,color: Color(0xFF4DD0E1)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Icon(Icons.mail,
                                                size: 30,
                                                color: Color(0xFF4DD0E1)
                                            ),
                                            SizedBox(width: 20,),
                                            new Text(
                                              document["Email"],
                                              style: GoogleFonts.ptSerif(fontSize: 15,color: Color(0xFF4DD0E1)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Icon(Icons.phone,
                                                size: 30,
                                                color: Color(0xFF4DD0E1)
                                            ),
                                            SizedBox(width: 20,),
                                            new Text(
                                              document["Phone"],
                                              style: GoogleFonts.ptSerif(fontSize: 20,color: Color(0xFF4DD0E1)),
                                            ),
                                          ],
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
}
