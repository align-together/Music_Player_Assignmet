import 'package:flutter/material.dart';

// Get the percentage of the total screen width.
double getWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * width / 100;
}

// Get the percentage of the total screen height.
double getHeight(BuildContext context, double height) {
  return MediaQuery.of(context).size.height * height / 100;
}

// Create a space with a specific height.
Widget heightSpace(double height) {
  return SizedBox(height: height);
}

// Create a space with a specific width.
Widget widthSpace(double width) {
  return SizedBox(width: width);
}

// Format the duration in milliseconds to a string in the format mm:ss.
String formatDuration(int milliseconds) {
  final seconds = (milliseconds / 1000).truncate();
  final minutes = (seconds / 60).truncate();
  final remainingSeconds = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}
