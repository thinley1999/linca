import 'package:animations/animations.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/pages/splash.dart';
import 'package:linca/terms_and_condition/policy_dialog.dart';
import 'package:linca/widget/sign_out.dart';
import 'package:linca/widget/Design.dart';
import 'package:shimmer/shimmer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: BackgroundPainter()),
          buildSignUp(),
        ],
      ),
    );
  }

  Widget buildSignUp() {
    return Container(
      margin: EdgeInsets.only(top: 100.0 ),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 130),
              child: Stack(
                children: [
                  ShaderMask(
                    child: Image.asset(
                      'assets/img1.png',
                      width: 300,
                    ),
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Color(0xFF76FF03).withOpacity(0.7), Colors.blue.withOpacity(0.9)],
                        // stops: [0.0,0.5],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                  ),
                ],
              ),
            ),
            _signInButton(),
            Image.asset('assets/logo2.png', width: 150,),
            Column(
              children: [
                Text('By signing in into LinCa, you are agreeing to our', style: TextStyle(color: Colors.blue),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.blue,
                      highlightColor: Colors.grey[300],
                      child: RichText(
                          text: TextSpan(
                            text: "Terms & Conditions ",
                              style: TextStyle(fontWeight: FontWeight.bold,),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                showModal(
                                    context: context,
                                    configuration: FadeScaleTransitionConfiguration(),
                                    builder: (context) {
                                      return PolicyDialog(
                                          mdFileName: 'terms_and_condition.md'
                                      );
                                    });
                              }
                          )
                      ),
                    ),
                    Text('and', style: TextStyle(color: Colors.blue),),
                    SizedBox(width: 3,),
                    Shimmer.fromColors(
                      baseColor: Colors.blue,
                      highlightColor: Colors.grey[300],
                      child: RichText(
                          text: TextSpan(
                              text: "Privacy Policy! ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                showModal(
                                    context: context,
                                    configuration: FadeScaleTransitionConfiguration(),
                                    builder: (context) {
                                      return PolicyDialog(
                                          mdFileName: 'privacy_policy.md'
                                      );
                                    });
                              }
                          )
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    final data = MediaQuery.of(context);
    return OutlineButton(      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return Splash();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Color(0xFF4DD0E1)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
               child:  GradientText(
                 text: 'Sign in with Google',
                 colors: <Color>[
                   Colors.blue,
                   Color(0xFF76FF03),
                 ],
                 style: GoogleFonts.anton(fontSize: 25, color: Colors.blue,),
                 textAlign: TextAlign.center,
               ),

            )
          ],
        ),
      ),
    );
  }
}