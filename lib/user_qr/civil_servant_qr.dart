import 'dart:convert';
import 'dart:ui';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:linca/main_drawer.dart';
import 'package:linca/user_qr/image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';


class CivilServantQr extends StatefulWidget {
  @override
  _CivilServantQrState createState() => _CivilServantQrState();
}

class _CivilServantQrState extends State<CivilServantQr> {
  GlobalKey imageKey = new GlobalKey();
  var db;
  void initState() {
    db = FirebaseFirestore.instance.collection("CivilServant").doc("Civi" + (_auth.currentUser).uid).snapshots();
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async{
    return (await _auth.currentUser).uid;
  }

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
              padding: EdgeInsets.only(bottom: 10),
              child: Center(
                child:  SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: new Column(
                    children: <Widget> [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue,width: 5),
                        ),
                        child: RepaintBoundary(
                          key: imageKey,
                          child: QrImage(
                            backgroundColor: Colors.white,
                            data: userDocument["UID"],
                            version: QrVersions.auto,
                            size: 250.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.only(left: 140.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 10,
                                    ),
                                  ]),
                              child: IconButton(
                                  icon: Icon(Icons.zoom_in),
                                  onPressed:  () async {
                                    RenderRepaintBoundary imageObject = imageKey.currentContext.findRenderObject();
                                    final image = await imageObject.toImage(pixelRatio: 2);
                                    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
                                    final pngBytes = byteData.buffer.asUint8List();

                                    Navigator.of(context
                                    ).push(MaterialPageRoute(builder: (context) => ImagePage(imageBytes: pngBytes,)));

                                  }
                              ),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 10,
                                    ),
                                  ]),
                              child: IconButton(
                                  icon: Icon(Icons.share),
                                  onPressed:  () async {
                                    RenderRepaintBoundary imageObject = imageKey.currentContext.findRenderObject();
                                    final image = await imageObject.toImage(pixelRatio: 2);
                                    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
                                    final pngBytes = byteData.buffer.asUint8List();
                                    final base64string = base64Encode(pngBytes);

                                    await Share.file(
                                      'esys image', 'qr.png', pngBytes, 'image/png',
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
