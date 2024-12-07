part of 'audio_bloc.dart';

abstract class AudioEvent {}

class DownloadFile extends AudioEvent {}

class PlayFile extends AudioEvent {}

class PauseFile extends AudioEvent {}

class PlaybackFinished extends AudioEvent {}

class SeekPosition extends AudioEvent {
  final int position;

  SeekPosition(this.position);
}

class UpdateProgress extends AudioEvent {
  final int currentDuration;
  final int totalDuration;

  UpdateProgress(this.currentDuration, this.totalDuration);
}
