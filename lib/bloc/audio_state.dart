part of 'audio_bloc.dart';

abstract class AudioState {}

class AudioInitial extends AudioState {}

class AudioLoading extends AudioState {}

class AudioDownloaded extends AudioState {}

class AudioPlaying extends AudioState {}

class AudioPaused extends AudioState {}

class AudioFinished extends AudioState {}

class AudioError extends AudioState {
  final String message;

  AudioError(this.message);
}
