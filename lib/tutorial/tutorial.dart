import 'package:flutter/material.dart';
import 'package:linca/main_drawer.dart';
import 'package:linca/tutorial/video_player_widget.dart';

class Tutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xFF212121),
    appBar: AppBar(
      backgroundColor: Color(0xFF212121),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.blue),
    ),
    drawer: MainDrawer(),
    body: SingleChildScrollView(
      child: VideoPlayerWidget(
        timestamps: <Duration>[
          Duration(minutes: 0, seconds: 14),
          Duration(minutes: 0, seconds: 48),
          Duration(minutes: 1, seconds: 18),
          Duration(minutes: 1, seconds: 47),
        ],
      ),
    ),
  );
}