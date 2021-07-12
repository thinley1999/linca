import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/admin/just_demo.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  var db;
  void initState() {
    db = FirebaseFirestore.instance.collectionGroup("Report").snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392869),
      body: StreamBuilder(
        stream: db,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData ?
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var userDocument = snapshot.data.docs;
                    return Table(
                      border: TableBorder.all(color: Colors.red[700]),
                      columnWidths: {
                        1:FlexColumnWidth(1),
                        2:FlexColumnWidth(0.2),
                      },
                      children: [
                        TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(userDocument[index].data()["Email"] ?? "",textAlign: TextAlign.center,style:  GoogleFonts.noticiaText(color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(userDocument[index].data()["Description"] ?? "",textAlign: TextAlign.justify,style:  GoogleFonts.noticiaText(color: Colors.white)),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                  iconSize: 20,
                                  color: Colors.white,
                                  onPressed: () async {
                                    await FirebaseFirestore.instance.collection("User").doc(userDocument[index].data()["UID"]).
                                    collection("Report").doc(userDocument[index].data()["SID"]).delete();
                                  }
                              ),
                        ]
                        ),
                      ],
                    );

                  },
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JustDemo(),
                        )
                    );
                  },
                  child: Text('see more >>>', style: GoogleFonts.noticiaText(color: Color(0xFF4DD0E1)),),
              ),
            ],
          ) : Container();
        },
      ),
    );
  }
}
