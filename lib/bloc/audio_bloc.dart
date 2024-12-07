import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:music_player/service/audio_service.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  String? filePath;
  int currentDuration = 0;
  int totalDuration = 0;

  final PlayerController playerController = PlayerController();

  AudioBloc() : super(AudioInitial()) {
    on<DownloadFile>(_onDownloadFile);
    on<PlayFile>(_onPlayFile);
    on<PauseFile>(_onPauseFile);
    on<PlaybackFinished>(_onPlaybackFinished);
    on<UpdateProgress>(_onUpdateProgress);

    playerController.onCurrentDurationChanged.listen((duration) {
      currentDuration = duration;
      totalDuration = playerController.maxDuration;
      add(UpdateProgress(duration, totalDuration));
    });

    playerController.onCompletion.listen((_) {
      add(PlaybackFinished());
    });
  }

  Future<void> _onDownloadFile(
      DownloadFile event, Emitter<AudioState> emit) async {
    emit(AudioLoading());
    try {
      filePath = await AudioService.getAudioFilePath();

      await playerController.preparePlayer(path: filePath!);
      totalDuration = playerController.maxDuration;
      playerController.setFinishMode(finishMode: FinishMode.pause);

      emit(AudioDownloaded());
    } catch (e) {
      debugPrint(e.toString());
      emit(AudioError(e.toString()));
    }
  }

  Future<void> _onPlayFile(PlayFile event, Emitter<AudioState> emit) async {
    try {
      await playerController.startPlayer();

      currentDuration = 0;
      totalDuration = playerController.maxDuration;

      emit(AudioPlaying());
    } catch (e) {
      debugPrint(e.toString());
      emit(AudioError(e.toString()));
    }
  }

  Future<void> _onPauseFile(PauseFile event, Emitter<AudioState> emit) async {
    try {
      await playerController.pausePlayer();
      emit(AudioPaused());
    } catch (e) {
      debugPrint(e.toString());
      emit(AudioError(e.toString()));
    }
  }

  void _onPlaybackFinished(PlaybackFinished event, Emitter<AudioState> emit) {
    currentDuration = 0;
    emit(AudioFinished());
  }

  void _onUpdateProgress(UpdateProgress event, Emitter<AudioState> emit) {
    currentDuration = event.currentDuration;
    totalDuration = event.totalDuration;
    if (state is AudioPlaying) {
      emit(AudioPlaying());
    } else if (state is AudioPaused) {
      emit(AudioPaused());
    }
  }
}
