part of 'text_to_speech_cubit.dart';

abstract class TextToSpeechState extends Equatable {
  const TextToSpeechState();

  @override
  List<Object> get props => [];
}

class TextToSpeechInitial extends TextToSpeechState {}

class TextToSpeechPlaying extends TextToSpeechState {}

class TextToSpeechStopped extends TextToSpeechState {}
