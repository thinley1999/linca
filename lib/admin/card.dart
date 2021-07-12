import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/admin/usercards.dart';

class AllCards extends StatefulWidget {
  @override
  _AllCardsState createState() => _AllCardsState();
}

class _AllCardsState extends State<AllCards> {
  List<Widget> cardlist =[
    Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: BusinessCards(),
      ),
    ),
    Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: CivilServantCards(),
      ),
    ),
    Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: StudentCards(),
      ),
    ),
    Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: MonasticCards(),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xff392869),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff392869),
          title: Text("User Cards", style: GoogleFonts.righteous(fontSize: 20, color: Colors.white),),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Color(0xFF4DD0E1),
            unselectedLabelColor: Colors.white,
            indicatorColor: Color(0xFF4DD0E1),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.business,
                  size: 30,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.work,
                  size: 25,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.people,
                  size: 30,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.person_pin,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: cardlist,
        ),
      ),
    );
  }
}
