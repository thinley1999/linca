import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/scanner/all_confetti.dart';
import 'package:linca/scanner/button_widget.dart';
import 'package:linca/main_drawer.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}

class _QRScanPageState extends State<QRScanPage> {
  String qrCode;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xFF212121),
    appBar: AppBar(
      backgroundColor: Color(0xFF212121),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.blue),
    ),
    drawer: MainDrawer(),
    body: Center(
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: SwipeDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    (qrCode != null) ? AllConfettiWidget(
                      child: Center(
              child: Text(
                'Scan result : $qrCode\n',
                style: GoogleFonts.lobster(fontSize: 15, color: Colors.red),
              ),
            ),
                    ) : Text(
                      'Scan result : $qrCode\n',
                      style: GoogleFonts.lobster(fontSize: 15, color: Colors.blue),
                    ),
                    SizedBox(height: 8),
                    GradientText(
                      text: 'QRCode',
                      colors: <Color>[
                        Colors.blue,
                        Color(0xFF76FF03),
                      ],
                      style: GoogleFonts.breeSerif(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5.0),
                    saveButton(),
                    SizedBox(height: 52),
                    ButtonWidget(
                      text: 'Scan from Camera',
                      onClicked: () async {
                        scanQRCode();
                      },
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.blue,Color(0xFF76FF03)]),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: FlatButton(
                          onPressed: () {
                        Navigator.pushNamed(context, '/image_scanner');
                      },
                          child: Text(
                              'Scan from Gallery',
                            style: GoogleFonts.breeSerif(fontSize: 30, color: Colors.white,),
                          )
                      ),
                    )
                  ],
                ),
                onSwipeUp: () {
                  setState(() {
                    Navigator.pushNamed(context, '/scanned_list');
                  });
                },
                onSwipeRight: () {
                  setState(() {
                    Navigator.pushNamed(context, '/home');
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
  );
  //
  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }


  Widget saveButton() {
    return qrCode != null
        ? RaisedButton(
        onPressed: () async {
          Map <String, dynamic> data = {
            "UID": qrCode,
            "Time": DateTime.now(),
          };
          await FirebaseFirestore.instance.collection("User").doc((_auth.currentUser).uid).collection("ScanList").doc(qrCode).set(data);
          Navigator.pushNamed(context, '/scanned_list');
        },
      child: Text('Save',style: GoogleFonts.anton(fontSize: 20,color: Colors.white),),
      color: Colors.blue,
      shape: StadiumBorder(),
    ) : Container();
  }

}