import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    @required this.text,
    @required this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Colors.blue,Color(0xFF76FF03)]),
      borderRadius: BorderRadius.circular(25),
    ),
    child: FlatButton(
      child: Text(
        text,
        style: GoogleFonts.breeSerif(fontSize: 30, color: Colors.white,),
      ),
      onPressed: onClicked,
    ),
  );
}
