import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/text_to_speech_services.dart';

class TextToSpeechCubit extends Cubit<TextToSpeechState> {
  final TestToSwitchServices ttsService;
  TextToSpeechCubit({required this.ttsService}) : super(TextToSpeechInitial());

  void startPlaying({required String textToRead}) async {
    emit(TextToSpeechPlaying());
    if (!ttsService.isPlaying) {
      await ttsService.speak(msg: textToRead);
    }
    emit(TextToSpeechStopped());
  }

  void stopPlaying() async {
    emit(TextToSpeechStopped());
    if (!ttsService.isPlaying) {
      await ttsService.stop();
    }
    emit(TextToSpeechPlaying());
  }
}

abstract class TextToSpeechState extends Equatable {
  const TextToSpeechState();

  @override
  List<Object> get props => [];
}

class TextToSpeechInitial extends TextToSpeechState {}

class TextToSpeechPlaying extends TextToSpeechState {}

class TextToSpeechStopped extends TextToSpeechState {}
