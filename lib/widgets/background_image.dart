import 'package:flutter/material.dart';
import 'package:music_player/utils/utils.dart';

class BackgroundImage extends StatefulWidget {
  const BackgroundImage({super.key});

  @override
  State<BackgroundImage> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: getHeight(context, 80),
        width: getWidth(context, 100),
        child: Image.asset(
          'assets/images/bg.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
