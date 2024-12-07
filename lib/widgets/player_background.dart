import 'package:flutter/material.dart';
import 'package:music_player/utils/utils.dart';

class PlayerBackground extends StatefulWidget {
  final Widget child;
  const PlayerBackground({super.key, required this.child});

  @override
  State<PlayerBackground> createState() => _PlayerBackgroundState();
}

class _PlayerBackgroundState extends State<PlayerBackground> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: getHeight(context, 40),
        width: getWidth(context, 100),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(42, 42, 42, 1),
              Color.fromRGBO(73, 73, 75, 1),
              Color.fromRGBO(100, 100, 100, 1),
            ],
          ),
          color: const Color.fromRGBO(49, 49, 49, .95),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(0, -5),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
