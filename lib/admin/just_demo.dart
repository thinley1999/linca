import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JustDemo extends StatefulWidget {
  @override
  _JustDemoState createState() => _JustDemoState();
}

class _JustDemoState extends State<JustDemo> {
  var map = Map();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Color(0xff392869),
     appBar: AppBar(
      elevation: 0,
       backgroundColor: Color(0xff392869),
     ),
     body:
     FutureBuilder <QuerySnapshot>(
         future: FirebaseFirestore.instance.collectionGroup("Report").get(),
         builder: (BuildContext context,
             AsyncSnapshot<QuerySnapshot> snapshot) {
           if (!snapshot.hasData) {
             return Container(
               height: 200.0,
               alignment: Alignment.center,
               child: CircularProgressIndicator(
                 valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
               ),
             );
           } else {
             return Column(
                 children: snapshot.data.docs.map((DocumentSnapshot document) {
                   if (!map.containsKey(document["Email"])) {
                     map[document["Email"]] = 1;
                   } else {
                     map[document["Email"]] += 1;
                   }
                   return new Text('$map', style: TextStyle(color: Colors.white, fontSize: 20),);
             }).toList(),
             );
           }
         }
     ),
   );
  }
}

