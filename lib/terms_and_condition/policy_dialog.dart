import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class PolicyDialog extends StatelessWidget {
  PolicyDialog({
    Key key,
    this.radius = 8,
    @required this.mdFileName
  }) : assert(mdFileName.contains('.md'), 'The file must contain .md extension'), super(key: key);

   final double radius;
   final String mdFileName;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 150)).then((value) {
                return rootBundle.loadString('assets/$mdFileName');
              }),
              builder: (context, snapshot) {
               if(snapshot.hasData){
                 return Markdown(
                     data: snapshot.data,
                 );
               }
               return Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
          FlatButton(
            padding: EdgeInsets.all(0),
              onPressed: () => Navigator.of(context).pop() ,
              //child: null,
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              )
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  )
              ),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: Text(
                'Close',
                style: GoogleFonts.squadaOne(fontSize: 20, color: Colors.white, ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
