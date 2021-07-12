import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linca/scanner/all_confetti.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linca/main_drawer.dart';

class ImageScanner extends StatefulWidget {
  @override
  _ImageScannerState createState() => _ImageScannerState();
}

class _ImageScannerState extends State<ImageScanner> {
  final picker = ImagePicker();
  String _qrcodeFile = '';
  String _data;

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
        body: Center(
          child: Column(
            children: <Widget>[
              (_data != null) ?
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: AllConfettiWidget(
                  child: Center(
                    child: Text(
                      'Scan result: $_data\n',
                      style: GoogleFonts.lobster(fontSize: 15, color: Colors.red),
                    ),
                  ),
                ),
              ): Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  'Scan result: $_data\n',
                  style: GoogleFonts.lobster(fontSize: 15, color: Colors.blue),
                ),
              ),
              ElevatedButton(
                child: Text("Select file",style: GoogleFonts.breeSerif(fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold),),
                onPressed: _getPhotoByGallery,
              ),
              _qrcodeFile.isEmpty
                  ? Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue,width: 5),
                ),
                margin: EdgeInsets.all(50),
                    child: Image.asset(
                'assets/qr.png',
              ),
                  )
                  : Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue,width: 5),
                  ),
                  margin: EdgeInsets.all(50),
                  child: Image.file(
                      File(_qrcodeFile))
              ),
              saveButton(),
            ],
          ),
        ),
    );
  }

  void _getPhotoByGallery() {
    Stream.fromFuture(picker.getImage(source: ImageSource.gallery))
        .flatMap((file) {
      setState(() {
        _qrcodeFile = file.path;
      });
      return Stream.fromFuture(QrCodeToolsPlugin.decodeFrom(file.path));
    }).listen((data) {
      setState(() {
        _data = data;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _data = '';
      });
      print('${error.toString()}');
    });
  }

  Widget saveButton() {
    return _data != null
        ? RaisedButton(
      onPressed: () async {
        Map <String, dynamic> data = {
          "UID": _data,
          "Time": DateTime.now(),
        };
        await FirebaseFirestore.instance.collection("User").doc((_auth.currentUser).uid).collection("ScanList").doc(_data).set(data);
        Navigator.pushNamed(context, '/scanned_list');
      },
      child: Text('Save',style: GoogleFonts.anton(fontSize: 20,color: Colors.white),),
      color: Colors.blue,
      shape: StadiumBorder(),
    ) : Container();
  }
}