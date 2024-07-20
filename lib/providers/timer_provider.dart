// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:async';

import 'package:flutter/material.dart';

class timer_provider with ChangeNotifier {
  int tempo_secondi = 0;
  Timer? timer;
  int tempo_iniziale_sec = 0;
  int count = 0;
  int count_cancella = 0;
  int count_startato = 0;

  void startato() {
    count_startato = 1;
  }

  void azzeraStartato() {
    count_startato = 0;
  }

  void toccato_c() {
    count_cancella++;
  }

  void toccato() {
    count++;
  }

  void azzera() {
    count = 0;
  }

  void setTempo(int tempo_scelto_sec) {
    tempo_secondi = tempo_scelto_sec;
    tempo_iniziale_sec = tempo_scelto_sec;
    notifyListeners();
  }

  void startTimer({bool reset = true}) {
    azzera();
    if (reset) {
      resetTimer();
      notifyListeners();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (tempo_secondi > 0) {
        tempo_secondi--;
        notifyListeners();
      } else {
        stopTimer(reset: false);
        notifyListeners();
      }
      notifyListeners();
    });
  }

  void resetTimer() {
    setTempo(tempo_iniziale_sec);
    notifyListeners();
  }

  void stopTimer({bool reset = true}) {
    timer?.cancel();
    notifyListeners();
  }

  void restartTimer({bool reset = false}) {
    if (reset) {
      resetTimer();
      notifyListeners();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (tempo_secondi > 0) {
        tempo_secondi--;
        notifyListeners();
      }
      notifyListeners();
    });
    count_startato;
    notifyListeners();
  }
}
