import 'package:flutter/material.dart';
import 'package:music_player/utils/colors.dart';
import 'package:music_player/utils/utils.dart';
import 'package:music_player/widgets/audio_player.dart';
import 'package:music_player/widgets/background_image.dart';
import 'package:music_player/widgets/player_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: getWidth(context, 100),
        child: Stack(
          children: [
            const BackgroundImage(),
            PlayerBackground(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: getHeight(context, 4),
                      horizontal: getWidth(context, 8),
                    ),
                    width: getWidth(context, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Instant Crush",
                          style: TextStyle(
                            color: CustomColor.textColor,
                            fontSize: 34,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                        heightSpace(10),
                        const Text(
                          "feat. Julian Casablancas",
                          style: TextStyle(
                            color: CustomColor.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  heightSpace(getHeight(context, 2)),
                  const AudioPlayerWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
