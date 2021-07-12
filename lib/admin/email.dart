import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/admin/utils.dart';

class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  var db;
  @override
  void initState() {
    db = FirebaseFirestore.instance.collectionGroup("UserData").snapshots();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392869),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: db,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return snapshot.hasData ?
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        var userDocument = snapshot.data.docs;
                        if(userDocument[index].data()["role"] == "user") {
                          return  Container(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Colors.purple,Colors.red]),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.person,
                                      ),
                                      iconSize: 30,
                                      color: Colors.white,
                                      onPressed: () async {
                                        showDialog(context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                backgroundColor: Colors.deepPurple,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(4.0)
                                                  ),
                                                  child: Stack(
                                                    overflow: Overflow.visible,
                                                    alignment: Alignment.topCenter,
                                                    children: [
                                                      Container(
                                                        height: 280,
                                                        width: 400,
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                                                          child: Column(
                                                            children: [
                                                              Text("Block Confirmation",style: GoogleFonts.righteous(fontSize: 20, color: Colors.white)),
                                                              SizedBox(height: 5,),
                                                              Text(
                                                                "Are you sure you want to block " +
                                                                    userDocument[index].data()["name"] +
                                                                    " ,Email ID " +
                                                                    userDocument[index].data()["email"] ,
                                                                style: TextStyle(fontSize: 20,color: Colors.white),
                                                              ),
                                                              SizedBox(height: 20,),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  FlatButton(
                                                                    //updating the role to admin
                                                                    onPressed: () async {
                                                                      Map <String, dynamic> data = {
                                                                        'role': 'block',
                                                                      };
                                                                      FirebaseFirestore.instance
                                                                          .collection("UserData")
                                                                          .doc(userDocument[index].data()["uid"])
                                                                          .update(data);
                                                                      Navigator.of(context).pop();
                                                                      //showing the success update admin message
                                                                      return showDialog(context: context,
                                                                          builder: (BuildContext context) {
                                                                            return AlertDialog(
                                                                              title: Text("Success",style: TextStyle(color: Colors.white),),
                                                                              content: Text(
                                                                                " User blocked successfully",
                                                                                style: TextStyle(fontSize: 20,color: Colors.white),
                                                                              ),
                                                                              backgroundColor: Colors.deepPurple,
                                                                              actions: [
                                                                                FlatButton(
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: Text('OK',style: TextStyle(color: Colors.white),),
                                                                                )
                                                                              ],
                                                                              elevation: 24.0,
                                                                            );
                                                                          }
                                                                      );
                                                                    },
                                                                    child: Text('BLOCK',style: GoogleFonts.righteous(fontSize: 15, color: Colors.white),),
                                                                  ),
                                                                  FlatButton(
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                    child: Text('CANCEL',style: GoogleFonts.righteous(fontSize: 15, color: Colors.white),),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: -60,
                                                          child: CircleAvatar(
                                                            backgroundImage: NetworkImage(
                                                              userDocument[index].data()["imageUrl"],
                                                            ),
                                                            radius: 60,
                                                          )
                                                      ),
                                                    ],
                                                  )
                                              );
                                            }
                                        );
                                      }
                                  ),
                                  ButtonTheme(
                                    minWidth: 280 ,
                                    child: FlatButton(
                                        onPressed: () async{
                                        },
                                        child: Column(
                                          children: [
                                            Text(userDocument[index].data()["email"], style: GoogleFonts.noticiaText(fontSize: 15, color: Colors.white)),
                                            Text(userDocument[index].data()["name"], style: GoogleFonts.noticiaText(fontSize: 15, color: Colors.white)),
                                          ],
                                        )),
                                  ),
                                  buildButton(
                                    text: 'Open Email',
                                    onClicked: () => Utils.openEmail(
                                      toEmail: userDocument[index].data()["email"],
                                      subject: 'LinCa Warning!',
                                      body: 'Your card is reported for being fake for five time. Please delete it, if it is not authenticate and create new one.'
                                          ' Else if it is reported for multiple time again then we will block your account from creating card again.',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (userDocument[index].data()["role"] == "block"){
                          return  Container(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Colors.purple,Colors.red]),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.person_add_disabled,
                                      ),
                                      iconSize: 30,
                                      color: Colors.white,
                                      onPressed: () async {
                                        showDialog(context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                  backgroundColor: Colors.deepPurple,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(4.0)
                                                  ),
                                                  child: Stack(
                                                    overflow: Overflow.visible,
                                                    alignment: Alignment.topCenter,
                                                    children: [
                                                      Container(
                                                        height: 280,
                                                        width: 400,
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                                                          child: Column(
                                                            children: [
                                                              Text("Unblock Confirmation",style: GoogleFonts.righteous(fontSize: 20, color: Colors.white)),
                                                              SizedBox(height: 5,),
                                                              Text(
                                                                "Are you sure you want to unblock " +
                                                                    userDocument[index].data()["name"] +
                                                                    " ,Email ID " +
                                                                    userDocument[index].data()["email"] ,
                                                                style: TextStyle(fontSize: 20,color: Colors.white),
                                                              ),
                                                              SizedBox(height: 20,),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  FlatButton(
                                                                    //updating the role to admin
                                                                    onPressed: () async {
                                                                      Map <String, dynamic> data = {
                                                                        'role': 'user',
                                                                      };
                                                                      FirebaseFirestore.instance
                                                                          .collection("UserData")
                                                                          .doc(userDocument[index].data()["uid"])
                                                                          .update(data);
                                                                      Navigator.of(context).pop();
                                                                      //showing the success update admin message
                                                                      return showDialog(context: context,
                                                                          builder: (BuildContext context) {
                                                                            return AlertDialog(
                                                                              title: Text("Success",style: TextStyle(color: Colors.white),),
                                                                              content: Text(
                                                                                " User unblocked successfully",
                                                                                style: TextStyle(fontSize: 20,color: Colors.white),
                                                                              ),
                                                                              backgroundColor: Colors.deepPurple,
                                                                              actions: [
                                                                                FlatButton(
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: Text('OK',style: TextStyle(color: Colors.white),),
                                                                                )
                                                                              ],
                                                                              elevation: 24.0,
                                                                            );
                                                                          }
                                                                      );
                                                                    },
                                                                    child: Text('UNBLOCK',style: GoogleFonts.righteous(fontSize: 15, color: Colors.white)),
                                                                  ),
                                                                  FlatButton(
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                    child: Text('CANCEL',style: GoogleFonts.righteous(fontSize: 15, color: Colors.white)),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: -60,
                                                          child: CircleAvatar(
                                                            backgroundImage: NetworkImage(
                                                              userDocument[index].data()["imageUrl"],
                                                            ),
                                                            radius: 60,
                                                          )
                                                      ),
                                                    ],
                                                  )
                                              );
                                            }
                                        );
                                      }
                                  ),
                                  ButtonTheme(
                                    minWidth: 250 ,
                                    child: FlatButton(
                                        onPressed: () async{
                                        },
                                        child: Column(
                                          children: [
                                            Text(userDocument[index].data()["email"], style: GoogleFonts.noticiaText(fontSize: 15, color: Colors.white)),
                                            Text(userDocument[index].data()["name"], style: GoogleFonts.noticiaText(fontSize: 15, color: Colors.white)),
                                          ],
                                        )),
                                  ),
                                  buildButton(
                                    text: 'Open Email',
                                    onClicked: () => Utils.openEmail(
                                      toEmail: userDocument[index].data()["email"],
                                      subject: 'LinCa Warning!',
                                      body: 'Your card is reported for being fake for five time. Please delete it, if it is not authenticate and create new one.'
                                          ' Else if it is reported for multiple time again then we will block your account from creating card again.',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ) : Container();
                }
            ),
          ),
        ],
      ),
    );
  }
  Widget buildButton({
    @required String text,
    @required VoidCallback onClicked,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: IconButton(
          icon: Icon(
            Icons.mail,
            color: Colors.white,
            size: 30,
          ),
          onPressed: onClicked,
          color: Colors.red,
        ),
      );
}
