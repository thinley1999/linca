import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linca/widget/sign_out.dart';
import 'package:linca/main_drawer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

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
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: <Widget> [
              Container(
                width: 150,
                height: 150,
                margin: EdgeInsets.only(top: 30),
                child:  CircleAvatar(
                  backgroundImage: NetworkImage(
                    imageUrl,
                  ),
                  radius: 60,
                  backgroundColor: Colors.transparent,
                ),
              ),
              Divider(
                height: 100,
                thickness: 1,
                color: Colors.blue,
              ),
              Text(
                'Name',
                style: GoogleFonts.noticiaText(fontSize: 30, color: Colors.blue)
              ),
              GradientText(
                text: name,
                colors: <Color>[
                  Colors.blue,
                  Color(0xFF76FF03),
                ],
                style: GoogleFonts.noticiaText(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0,),
              Text(
                'Email',
                style: GoogleFonts.noticiaText(fontSize: 30, color: Colors.blue),
              ),
              GradientText(
                text: email,
                colors: <Color>[
                  Colors.blue,
                  Color(0xFF76FF03),
                ],
                style: GoogleFonts.noticiaText(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
