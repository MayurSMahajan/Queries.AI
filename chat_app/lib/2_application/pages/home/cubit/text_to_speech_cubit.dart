import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/text_to_speech_services.dart';

part 'text_to_speech_state.dart';

class TextToSpeechCubit extends Cubit<TextToSpeechState> {
  final ttsService = TestToSwitchServices();
  TextToSpeechCubit() : super(TextToSpeechInitial());

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
