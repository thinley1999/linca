import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/widget/sign_in.dart';
import 'package:linca/widget/sign_out.dart';

import 'admin/usercards.dart';

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xff392869),
          //other styles
        ),
        child: Drawer(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.purple,Colors.red]),
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
                leading: Icon(Icons.business, color: Color(0xFF4DD0E1),size: 30),
                title: Text(
                  'Business',
                  style: GoogleFonts.noticiaText(fontSize: 23,color: Color(0xFF4DD0E1)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BusinessCards(),
                      )
                  );
                },
              ),
              Divider(
                thickness: 1,
                color: Color(0xFF4DD0E1),
              ),
              ListTile(
                leading: Icon(Icons.work, color: Color(0xFF4DD0E1),size: 30),
                title: Text(
                  'Civil Servant',
                  style: GoogleFonts.noticiaText(fontSize: 23,color: Color(0xFF4DD0E1)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CivilServantCards(),
                      )
                  );
                },
              ),
              Divider(
                thickness: 1,
                color: Color(0xFF4DD0E1),
              ),
              ListTile(
                leading: Icon(Icons.people, color: Color(0xFF4DD0E1),size: 30),
                title: Text(
                  'College Student',
                  style: GoogleFonts.noticiaText(fontSize: 23,color: Color(0xFF4DD0E1)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StudentCards(),
                      )
                  );
                },
              ),
              Divider(
                thickness: 1,
                color: Color(0xFF4DD0E1),
              ),
              ListTile(
                leading: Icon(Icons.person_pin, color: Color(0xFF4DD0E1),size: 30),
                title: Text(
                  'Monastic',
                  style: GoogleFonts.noticiaText(fontSize: 23,color: Color(0xFF4DD0E1)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MonasticCards(),
                      )
                  );
                },
              ),
              Divider(
                thickness: 1,
                color: Color(0xFF4DD0E1),
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Color(0xFF4DD0E1),size: 30),
                title: Text(
                  'Log Out',
                  style: GoogleFonts.noticiaText(fontSize: 23,color: Color(0xFF4DD0E1)),
                ),
                onTap: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
                },
              ),
            ],
          ),
        )
    );
  }
}
