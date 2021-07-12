import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/main_drawer.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:swipedetector/swipedetector.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _allow = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(_allow); // if true allow back else block it
      },
      child: Scaffold(
        backgroundColor: Color(0xFF212121),
          appBar: AppBar(
            backgroundColor: Color(0xFF212121),
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.blue),
          ),
          drawer:  MainDrawer(),
          body: SafeArea(
            child: Container(
                child: Row(
                children: [
                  Expanded(
                    child: SwipeDetector(
                      child: Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    NeuCard(
                                      curveType: CurveType.concave,
                                      bevel: 4,
                                      decoration:  NeumorphicDecoration(
                                        color: Color(0xFF4DD0E1),
                                          borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [Colors.blue,Color(0xFF76FF03)]),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        margin: EdgeInsets.only(bottom: 3),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            CircleAvatar(
                                              backgroundImage: AssetImage('assets/business.jpg'),
                                              radius: 40,
                                              backgroundColor: Colors.transparent,
                                            ),
                                            ButtonTheme(
                                              minWidth: 210,
                                              child: FlatButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, '/business');
                                                  },
                                                  child: Text(
                                                    'Business',
                                                    style: GoogleFonts.lobster(fontSize: 25, color: Colors.white,letterSpacing: 1),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 20),
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.qr_code,
                                                    color: Colors.blue,
                                                    size: 60,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, '/business_qr');
                                                  }
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    NeuCard(
                                      curveType: CurveType.concave,
                                      bevel: 4,
                                      decoration:  NeumorphicDecoration(
                                        color: Color(0xFF4DD0E1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [Colors.blue,Color(0xFF76FF03)]),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        margin: EdgeInsets.only(bottom: 3),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            CircleAvatar(
                                              backgroundImage: AssetImage('assets/civilservant.jpg'),
                                              radius: 40,
                                              backgroundColor: Colors.transparent,
                                            ),
                                            ButtonTheme(
                                              minWidth: 210,
                                              child: FlatButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, '/civil_servant');
                                                  },
                                                  child: Text(
                                                    'Civil Servant',
                                                    style: GoogleFonts.lobster(fontSize: 25, color: Colors.white,letterSpacing: 1),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 20),
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.qr_code,
                                                    color: Colors.blue,
                                                    size: 60,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, '/civil_servant_qr');
                                                  }
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    NeuCard(
                                      curveType: CurveType.concave,
                                      bevel: 4,
                                      decoration:  NeumorphicDecoration(
                                        color: Color(0xFF4DD0E1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [Colors.blue,Color(0xFF76FF03)]),
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        margin: EdgeInsets.only(bottom: 3),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            CircleAvatar(
                                              backgroundImage: AssetImage('assets/student.jpg'),
                                              radius: 40,
                                              backgroundColor: Colors.transparent,
                                            ),
                                            ButtonTheme(
                                              minWidth: 210,
                                              child: FlatButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, '/college_student');
                                                  },
                                                  child: Text(
                                                    'Student',
                                                    style: GoogleFonts.lobster(fontSize: 25, color: Colors.white,letterSpacing: 1),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 20),
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.qr_code,
                                                    color: Colors.blue,
                                                    size: 60,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, '/college_student_qr');
                                                  }
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    NeuCard(
                                      curveType: CurveType.concave,
                                      bevel: 4,
                                      decoration:  NeumorphicDecoration(
                                        color: Color(0xFF4DD0E1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [Colors.blue,Color(0xFF76FF03)]),
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        margin: EdgeInsets.only(bottom: 3),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            CircleAvatar(
                                              backgroundImage: AssetImage('assets/monk.jpg'),
                                              radius: 40,
                                              backgroundColor: Colors.transparent,
                                            ),
                                            ButtonTheme(
                                              minWidth: 210,
                                              child: FlatButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, '/monastic');
                                                  },
                                                  child: Text(
                                                    'Monastic',
                                                    style: GoogleFonts.lobster(fontSize: 25, color: Colors.white,letterSpacing: 1),
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 20,),
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.qr_code,
                                                    color: Colors.blue,
                                                    size: 60,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, '/monastic_qr');
                                                  }
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      onSwipeUp: () {
                        setState(() {
                         Navigator.pushNamed(context, '/scanned_list');
                        });
                      },
                      onSwipeLeft: () {
                        setState(() {
                         Navigator.pushNamed(context, '/scanner');
                        });
                      },
        swipeConfiguration: SwipeConfiguration(
              verticalSwipeMinVelocity: 100.0,
              verticalSwipeMinDisplacement: 50.0,
              verticalSwipeMaxWidthThreshold:100.0,
              horizontalSwipeMaxHeightThreshold: 50.0,
              horizontalSwipeMinDisplacement:50.0,
              horizontalSwipeMinVelocity: 200.0),
      ),
                    ),
                ],
              ),
            ),
          ),
        ),
    );  }
}
