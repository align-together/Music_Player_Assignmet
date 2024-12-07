import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/bloc/audio_bloc.dart';
import 'package:music_player/utils/colors.dart';
import 'package:music_player/utils/utils.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    final audioBloc = BlocProvider.of<AudioBloc>(context);
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        debugPrint('Current state: $state');
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (state is AudioError)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Unable to load file. Try again ?",
                    style: TextStyle(
                      color: CustomColor.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                    heightSpace(getHeight(context, 2)),
                    IconButton(
                    onPressed: () {
                      audioBloc.add(DownloadFile());
                    },
                    icon: const Icon(Icons.refresh_outlined,
                        color: CustomColor.textColor, size: 25),
                  )
                ],
              )
            else if (state is AudioLoading)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Loading",
                    style: TextStyle(
                      color: CustomColor.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                  widthSpace(10),
                  const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: CustomColor.textColor,
                      strokeWidth: 2,
                    ),
                  ),
                ],
              )
            else ...[
              SizedBox(
                width: getWidth(context, 100),
                height: 50,
                child: AudioFileWaveforms(
                  size: Size(getWidth(context, 100), 50),
                  playerController: audioBloc.playerController,
                  waveformType: WaveformType.fitWidth,
                  playerWaveStyle: const PlayerWaveStyle(
                    spacing: 5,
                    scaleFactor: 100,
                    fixedWaveColor: CustomColor.fixedWaveColor,
                    liveWaveColor: CustomColor.textColor,
                  ),
                ),
              ),
              heightSpace(getHeight(context, 4)),
              Text(
                formatDuration(audioBloc.currentDuration),
                style: const TextStyle(
                  color: CustomColor.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
              heightSpace(2),
              if (state is AudioPlaying)
                IconButton(
                  icon: Container(
                    decoration: const BoxDecoration(
                      // Background color with opacity
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x26000000),
                          offset: Offset(0, 10),
                          blurRadius: 25,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/images/pause.svg',
                    ),
                  ),
                  // color: CustomColor.textColor,
                  onPressed: () => audioBloc.add(PauseFile()),
                ),
              if (state is AudioPaused ||
                  state is AudioFinished ||
                  state is AudioDownloaded)
                IconButton(
                  icon:
                  ClipOval(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(237, 237, 237, 0.5),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15), // Shadow color with opacity
                            offset: Offset(0, 10), // Shadow offset
                            blurRadius: 25, // Shadow blur effect
                            spreadRadius: 0, // Spread of the shadow
                          ),
                        ],
                      ),
                      child: SvgPicture.asset('assets/images/play.svg',width: 65,height: 65,),
                    ),
                  ),
                  onPressed: () => audioBloc.add(PlayFile()),
                ),
            ]
          ],
        );
      },
    );
  }
}
