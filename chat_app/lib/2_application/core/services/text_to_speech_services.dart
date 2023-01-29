import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class TestToSwitchServices {
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 1;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  TestToSwitchServices() {
    initTts();
  }

  void initTts() {
    debugPrint("Init TTS called");
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      debugPrint("Playing");
      ttsState = TtsState.playing;
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        debugPrint("TTS Initialized");
      });
    }

    flutterTts.setCompletionHandler(() {
      debugPrint("Complete");
      ttsState = TtsState.stopped;
    });

    flutterTts.setCancelHandler(() {
      debugPrint("Cancel");
      ttsState = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      debugPrint("Paused");
      ttsState = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      debugPrint("Continued");
      ttsState = TtsState.continued;
    });

    flutterTts.setErrorHandler((msg) {
      debugPrint("error: $msg");
      ttsState = TtsState.stopped;
    });
  }

  Future _getDefaultEngine() async {
    await flutterTts.getDefaultEngine;
  }

  Future _getDefaultVoice() async {
    await flutterTts.getDefaultVoice;
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future speak({required String msg}) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (msg.isNotEmpty) {
      await flutterTts.speak(msg);
    }
  }

  Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1) {
      ttsState = TtsState.stopped;
    }
  }

  // void _dispose() {
  //   flutterTts.stop();
  // }

  //This method is not trustable, since it may not work on some devices
  // Future _pause() async {
  //   var result = await flutterTts.pause();
  //   if (result == 1) ttsState = TtsState.paused);
  // }
}
