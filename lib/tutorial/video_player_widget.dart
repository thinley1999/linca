import 'package:flutter/material.dart';
import 'package:linca/tutorial/custom_control_widget.dart';
import 'package:linca/tutorial/video_control_widget.dart';
import 'package:linca/tutorial/video_progress_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final List<Duration> timestamps;

  const VideoPlayerWidget({
    @required this.timestamps,
    Key key,
  }) : super(key: key);
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/demo_video.mp4");

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(controller),
            VideoControlsWidget(controller: controller),
            CustomVideoProgressIndicator(
              controller,
              allowScrubbing: true,
              timestamps: widget.timestamps,
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      CustomControlsWidget(
        controller: controller,
        timestamps: widget.timestamps,
      ),
      SizedBox(height: 12),
    ],
  );
}