import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final imageBytes;
  const ImagePage({Key key, this.imageBytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.memory(imageBytes, width: 350, fit: BoxFit.cover,),
      ),
    );
  }
}
