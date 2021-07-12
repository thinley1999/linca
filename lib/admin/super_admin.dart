import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/admin/email.dart';
import 'package:linca/admin/report.dart';
import 'package:linca/admin_drawer.dart';
import 'package:linca/pages/home_page.dart';
import 'package:linca/widget/sign_out.dart';


DocumentSnapshot result;bool mm = false;
class SuperAdminPage extends StatefulWidget {
  @override
  AdminPageState createState() => AdminPageState();
}

class AdminPageState extends State<SuperAdminPage> {
  bool _allow = false;
  List<Widget> containers = [
    Container(child: SuperAdminHomePage()),
    //admin adding and user deleting
    Container(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              //to get the data form the firestore for the list
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('UserData').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: Text('LOADING...',style: TextStyle(color: Colors.white),),
                    );
                  }
                  return ListView(
                    children: snapshot.data.docs.map((document){
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.purple,Colors.red]),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  document['imageUrl'],
                                ),
                                radius: 30,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            //displaying the details of all the user
                            ButtonTheme(
                              minWidth: 280,
                              child: FlatButton(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(document['email'],style: GoogleFonts.noticiaText(fontSize: 15, color: Colors.white)),

                                      ],
                                    ),
                                    Text(document['name']+ "  [" +document['role']+ "]",style: GoogleFonts.noticiaText(fontSize: 15, color: Colors.white)),
                                  ],
                                ),
                                onPressed: null,
                              ),
                            ),
                            //add button icon
                            IconButton(
                              onPressed: (){
                                String uid = document['uid'];

                                //checking if the user is admin or not
                                if(document['role'] == 'admin'){
                                  showDialog(context: context,
                                      builder: (BuildContext context) {
                                        // return AlertDialog(
                                        //   title: Text("NOTE",style: GoogleFonts.righteous(fontSize: 20, color: Colors.white)),
                                        //   content: Text( document['name']+
                                        //       " is " +document['role'],
                                        //     style: GoogleFonts.noticiaText(fontSize: 20, color: Colors.white),
                                        //   ),
                                        //   backgroundColor: Colors.purple,
                                        //   actions: [
                                        //     FlatButton(
                                        //       onPressed: () {
                                        //         Navigator.of(context).pop();
                                        //       },
                                        //       child: Text('OK',style: GoogleFonts.righteous(fontSize: 15, color: Colors.white),),
                                        //     )
                                        //   ],
                                        //   elevation: 24.0,
                                        //
                                        // );
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
                                                  height: 200,
                                                  width: 400,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                                                    child: Column(
                                                      children: [
                                                        Text("Note",style: GoogleFonts.righteous(fontSize: 20, color: Colors.white)),
                                                        SizedBox(height: 5,),
                                                        Text(
                                                              document["name"] + " is admin" ,
                                                          style: TextStyle(fontSize: 20,color: Colors.white),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            FlatButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Text('OK',style: GoogleFonts.righteous(fontSize: 15, color: Colors.white),),
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
                                                        document["imageUrl"],
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

                                else {
                                  //pop up message for add confirmation
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
                                                  height: 300,
                                                  width: 400,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                                                    child: Column(
                                                      children: [
                                                        Text("Admin Confirmation",style: GoogleFonts.righteous(fontSize: 20, color: Colors.white)),
                                                        SizedBox(height: 5,),
                                                        Text(
                                                          "Are you sure you want add " +
                                                              document["name"] +
                                                              " ,Email ID " +
                                                              document["email"] + " as admin" ,
                                                          style: TextStyle(fontSize: 20,color: Colors.white),
                                                        ),
                                                        SizedBox(height: 20,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            FlatButton(
                                                              onPressed: () {
                                                                final FirebaseAuth _auth = FirebaseAuth.instance;
                                                                String currentuserid = _auth.currentUser.uid;
                                                                //assigning the role of super admin
                                                                Map <String, dynamic> data = {
                                                                  'role': 'admin',
                                                                };
                                                                print(uid);
                                                                FirebaseFirestore.instance
                                                                    .collection("UserData")
                                                                    .doc(uid)
                                                                    .update(data);

                                                                //demoting to user
                                                                Map <String, dynamic> data2 = {
                                                                  'role': 'user',
                                                                };
                                                                print(uid);
                                                                FirebaseFirestore.instance
                                                                    .collection("UserData")
                                                                    .doc(currentuserid)
                                                                    .update(data2);

                                                                //redirecting back to user page
                                                                Navigator.of(context).pop();
                                                                Navigator.of(context).pop();
                                                                Navigator.push(context,
                                                                    MaterialPageRoute(builder: (context) => HomePage(),
                                                                    )
                                                                );
                                                              },
                                                              child: Text('CONFIRM',style: GoogleFonts.righteous(fontSize: 15, color: Colors.white)),
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
                                                        document["imageUrl"],
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
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      child: Report(),
    ),
    Container(
      child: Email(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: WillPopScope(
        onWillPop: () {
          return Future.value(_allow); // if true allow back else block it
        },
        child: Scaffold(
          backgroundColor: Color(0xff392869),
          appBar: AppBar(
            title: Text("ADMIN DASHBOARD", style: GoogleFonts.righteous(fontSize: 20, color: Color(0xFF4DD0E1))),
            bottom: TabBar(
              labelColor: Color(0xFF4DD0E1),
              labelStyle: GoogleFonts.righteous(fontSize: 15),
              unselectedLabelColor: Colors.white,
              indicatorColor: Color(0xFF4DD0E1),
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.person_add,
                    size: 30,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.report,
                    size: 30,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.person_add_disabled,
                    size: 30,
                  ),
                ),
              ],
            ),
            backgroundColor: Color(0xff392869),
            centerTitle: true,
            // actions: [
            //   IconButton(
            //       icon: Icon(Icons.search),
            //       onPressed: (){
            //         showSearch(context: context, delegate: DataSearch());
            //       }
            //   )
            // ],
          ),
          drawer: AdminDrawer(),
          body: TabBarView(
            children: containers,
          ),
        ),
      ),
    );
  }
}
// class DataSearch extends SearchDelegate<String>{
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: (){
//           query = "";
//           return showSearch(context: context, delegate: DataSearch());
//         },
//       ),
//     ];
//     //return null;
//
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     // return IconButton(icon: Icon(Icons.g_translate), onPressed: (){});
//     return null;
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('UserData').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//         return ListView(
//           children: snapshot.data.docs.map((document){
//             if(query == document['email']){
//               return Container(
//                 decoration: BoxDecoration(
//                   // gradient: LinearGradient(colors: [Colors.purple,Colors.red]),
//                   color: Colors.grey[600],
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//                 padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
//                 margin: EdgeInsets.only(bottom: 10),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       onPressed: (){
//                         String uid = document['uid'];
//                         //email = document['email'];
//                         // Map <String, dynamic> data = {
//                         //   'role':'user',
//                         // };
//                         // FirebaseFirestore.instance.collection("UserData").doc(uid).update(data);
//                         //checking if the user is admin or not
//                         if(document['role'] == 'superadmin'){
//                           showDialog(context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text("NOTE",style: TextStyle(color: Colors.white),),
//                                   content: Text( document['name']+
//                                       " is " +document['role'],
//                                     style: TextStyle(fontSize: 20,color: Colors.white),
//                                   ),
//                                   backgroundColor: Colors.purple,
//                                   actions: [
//                                     FlatButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('OK',style: TextStyle(color: Colors.white),),
//                                     )
//                                   ],
//                                   elevation: 24.0,
//
//                                 );
//                               }
//                           );
//                         }
//                         //if the user is admin
//                         else if(document['role'] == 'admin'){
//                           showDialog(context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text("NOTE",style: TextStyle(color: Colors.white),),
//                                   content: Text( document['name']+
//                                       " is already an " +document['role'],
//                                     style: TextStyle(fontSize: 20,color: Colors.white),
//                                   ),
//                                   backgroundColor: Colors.purple,
//                                   actions: [
//                                     FlatButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('OK',style: TextStyle(color: Colors.white),),
//                                     ),
//                                   ],
//                                   elevation: 24.0,
//
//                                 );
//                               }
//                           );
//                         }
//                         else {
//                           //pop up message for add confirmation
//                           showDialog(context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text("Admin Confirmation",style: TextStyle(color: Colors.white),),
//                                   content: Text(
//                                     "Are you sure you want to add " +
//                                         document['name'] +
//                                         " ,Email ID " +
//                                         document['email'] + " as admin.",
//                                     style: TextStyle(fontSize: 20,color: Colors.white),
//                                   ),
//                                   backgroundColor: Colors.deepPurple,
//                                   actions: [
//                                     FlatButton(
//                                       //updating the role to admin
//                                       onPressed: () async {
//                                         Map <String, dynamic> data = {
//                                           'role': 'admin',
//                                         };
//                                         print(uid);
//                                         FirebaseFirestore.instance
//                                             .collection("UserData")
//                                             .doc(uid)
//                                             .update(data);
//                                         Navigator.of(context).pop();
//                                         //showing the success update admin message
//                                         return showDialog(context: context,
//                                             builder: (BuildContext context) {
//                                               return AlertDialog(
//                                                 title: Text("Success",style: TextStyle(color: Colors.white),),
//                                                 content: Text(
//                                                   " Admin added successfully",
//                                                   style: TextStyle(fontSize: 20,color: Colors.white),
//                                                 ),
//                                                 backgroundColor: Colors.deepPurple,
//                                                 actions: [
//                                                   FlatButton(
//                                                     onPressed: () {
//                                                       Navigator.of(context).pop();
//                                                     },
//                                                     child: Text('OK',style: TextStyle(color: Colors.white),),
//                                                   )
//                                                 ],
//                                                 elevation: 24.0,
//                                               );
//                                             }
//                                         );
//                                       },
//                                       child: Text('ADD',style: TextStyle(color: Colors.white),),
//                                     ),
//                                     FlatButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('CANCLE',style: TextStyle(color: Colors.white),),
//                                     )
//                                   ],
//                                   elevation: 24.0,
//
//                                 );
//                               }
//                           );
//                         }
//                       },
//                       icon: Icon(
//                         Icons.add,
//                         color: Colors.yellow,
//                       ),
//                     ),
//                     //displaying the details of all the user
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Text(document['email'],style: TextStyle(fontSize: 20.0,color: Colors.white),),
//                           Text(document['name']+ "  [" +document['role']+ "]",style: TextStyle(fontSize: 15.0,color: Colors.white),),
//                         ],
//                       ),
//                     ),
//                     //deleting the user form the firestore
//                     IconButton(
//                       onPressed: (){
//
//                         String uid = document['uid'];
//                         if(document['role'] == "superadmin"){
//                           showDialog(context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text("NOTE",style: TextStyle(color: Colors.white),),
//                                   content: Text( document['name']+
//                                       " is an Super Admin. You cannot delete it.",
//                                     style: TextStyle(fontSize: 20,color: Colors.white),
//                                   ),
//                                   backgroundColor: Colors.purple,
//                                   actions: [
//                                     FlatButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('OK',style: TextStyle(color: Colors.white),),
//                                     )
//                                   ],
//                                   elevation: 24.0,
//
//                                 );
//                               }
//                           );
//                         }
//                         else{
//                           showDialog(context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text("Delete User",style: TextStyle(color: Colors.white),),
//                                   content: Text(
//                                     "Are you sure you want to delete " +
//                                         document['name'] +
//                                         " from the list or assign role to USER",
//                                     style: TextStyle(fontSize: 20,color: Colors.white),
//                                   ),
//                                   backgroundColor: Colors.deepPurple,
//                                   actions: [
//                                     FlatButton(
//                                       onPressed: () async {
//                                         Map <String, dynamic> data = {
//                                           'role': 'user',
//                                         };
//                                         print(uid);
//                                         FirebaseFirestore.instance
//                                             .collection("UserData")
//                                             .doc(uid)
//                                             .update(data);
//                                         Navigator.of(context).pop();
//                                         //showing the success update admin message
//                                         return showDialog(context: context,
//                                             builder: (BuildContext context) {
//                                               return AlertDialog(
//                                                 title: Text("Success",style: TextStyle(color: Colors.white),),
//                                                 content: Text(
//                                                   " User added successfully",
//                                                   style: TextStyle(fontSize: 20,color: Colors.white),
//                                                 ),
//                                                 backgroundColor: Colors.deepPurple,
//                                                 actions: [
//                                                   FlatButton(
//                                                     onPressed: () {
//                                                       Navigator.of(context).pop();
//                                                     },
//                                                     child: Text('OK',style: TextStyle(color: Colors.white),),
//                                                   )
//                                                 ],
//                                                 elevation: 24.0,
//                                               );
//                                             }
//                                         );
//                                       },
//                                       child: Text('Add as USER',style: TextStyle(color: Colors.white),),
//                                     ),
//                                     FlatButton(
//                                       //updating the role to admin
//                                       onPressed: () async {
//                                         print(uid);
//                                         FirebaseFirestore.instance
//                                             .collection("UserData")
//                                             .doc(uid)
//                                             .delete();
//                                         Navigator.of(context).pop();
//                                         //showing the success update admin message
//                                         return showDialog(context: context,
//                                             builder: (BuildContext context) {
//                                               return AlertDialog(
//                                                 title: Text("Success",style: TextStyle(color: Colors.white),),
//                                                 content: Text(
//                                                   " User Deleted Successfully",
//                                                   style: TextStyle(fontSize: 20,color: Colors.white),
//                                                 ),
//                                                 backgroundColor: Colors.deepPurple,
//                                                 actions: [
//                                                   FlatButton(
//                                                     onPressed: () {
//                                                       Navigator.of(context).pop();
//                                                     },
//                                                     child: Text('OK',style: TextStyle(color: Colors.white),),
//                                                   )
//                                                 ],
//                                                 elevation: 24.0,
//                                               );
//                                             }
//                                         );
//                                       },
//                                       child: Text('DELETE',style: TextStyle(color: Colors.white),),
//                                     ),
//                                     FlatButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('CANCLE',style: TextStyle(color: Colors.white),),
//                                     )
//                                   ],
//                                   elevation: 24.0,
//
//                                 );
//                               }
//                           );
//                         }
//                       },
//                       icon: Icon(
//                         Icons.delete,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//             else{
//               return Text(' ');
//             }
//           }).toList(),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Text(" ");
//
//   }
//
// }


