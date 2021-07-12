import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linca/admin/super_admin.dart';
import 'package:linca/pages/home_page.dart';
import 'package:linca/widget/sign_in.dart';
import 'package:linca/widget/sign_out.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  verifyAdmin() async{
    String a = _auth.currentUser.uid;
    DocumentSnapshot result = await FirebaseFirestore.instance.collection("UserData").doc(a).get();
    if(result['role'] == 'admin'){
      // Navigator.of(context).pop();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SuperAdminPage(),
          )
      );
    }  else if(result['role'] == 'block') {
      signOutGoogle();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
      Fluttertoast.showToast(
          msg: "Your account have been blocked",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage(),
          )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      backgroundColor: Colors.black,
      image: Image.asset('assets/loading.gif'),
      loaderColor: Colors.white,
      photoSize: 150,
      navigateAfterSeconds: verifyAdmin(),
    );
  }
}
