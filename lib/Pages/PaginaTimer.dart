// ignore_for_file: prefer_const_constructors,  non_constant_identifier_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/providers/timer_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/button_widget.dart';

class PaginaTimer extends StatefulWidget {
  const PaginaTimer({super.key});

  @override
  State<PaginaTimer> createState() => _PaginaTimerState();
}

class _PaginaTimerState extends State<PaginaTimer> {
  late int tempo_secondi = 0;
  Timer? timer;
  late timer_provider _timerProvider;
  Duration selectedDuration = Duration(hours: 0, minutes: 0, seconds: 0);

  @override
  void initState() {
    super.initState();
    _timerProvider = Provider.of<timer_provider>(context, listen: false);
  }

  void _showTimePicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      child: Text(
                        'DONE',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hms,
                      initialTimerDuration: selectedDuration,
                      onTimerDurationChanged: (Duration duration) {
                        setState(() {
                          selectedDuration = duration;
                          selectTime();
                        });
                      }),
                )
              ],
            ),
          );
        });
  }

  void selectTime({bool scelto = false}) {
    tempo_secondi = selectedDuration.inSeconds;
    _timerProvider.setTempo(tempo_secondi);
    context.read<timer_provider>().setTempo(tempo_secondi);
  }

  void restartTimer({bool reset = false}) {
    context.read<timer_provider>().restartTimer();
  }

  void startTimer({bool reset = true}) {
    context.read<timer_provider>().startTimer();
  }

  void resetTimer() {
    context.read<timer_provider>().resetTimer();
  }

  void stopTimer({bool reset = true}) {
    context.read<timer_provider>().stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: coloreSchermata(),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/prima');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      backgroundColor: coloreSchermata(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTimer(),
            SizedBox(
              height: 80,
            ),
            buildButtons(),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            _showTimePicker(context);
            context.read<timer_provider>().azzeraStartato();
          },
          child: Text(
            'SELECT TIME',
            style: TextStyle(
                fontWeight: FontWeight.w800, color: Colors.white, fontSize: 15),
          )),
    );
  }

  Color coloreSchermata() {
    if (context.watch<timer_provider>().count_startato == 1) {
      if (context.watch<timer_provider>().tempo_secondi % 2 != 0 &&
          context.watch<timer_provider>().tempo_secondi <= 5) {
        return Colors.red;
      }
    }
    return Colors.black;
  }

  Widget buildButtons() {
    final isRunning = context.watch<timer_provider>().timer == null
        ? false
        : context.watch<timer_provider>().timer!.isActive;
    final isCompleted = context.watch<timer_provider>().tempo_secondi == 0 ||
        context.watch<timer_provider>().tempo_secondi ==
            selectedDuration.inSeconds;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: isRunning ? 'Pause' : 'Resume',
                onClicked: () {
                  if (isRunning) {
                    stopTimer(reset: false);
                    context.read<timer_provider>().toccato();
                  } else {
                    restartTimer(reset: false);
                  }
                },
              ),
              ButtonWidget(
                text: 'Cancel',
                onClicked: () {
                  stopTimer();
                  resetTimer();
                  context.read<timer_provider>().azzera();
                  context.read<timer_provider>().toccato_c();
                },
              ),
            ],
          )
        : ButtonWidget(
            text: 'start timer',
            onClicked: () {
              if (tempo_secondi == 0) {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Seleziona il tempo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                );
              } else {
                startTimer();
                context.read<timer_provider>().startato();
              }
            },
          );
  }

  Widget buildTimer() {
    if (tempo_secondi > 0) {
      return SizedBox(
          width: 200,
          height: 200,
          child: Stack(fit: StackFit.expand, children: [
            CircularProgressIndicator(
              value: 1 -
                  context.watch<timer_provider>().tempo_secondi /
                      selectedDuration.inSeconds,
              strokeWidth: 10,
              backgroundColor: Colors.red,
            ),
            Center(child: buildTime())
          ]));
    }
    if (tempo_secondi == 0 &&
        context.watch<timer_provider>().tempo_secondi > 0) {
      return SizedBox(
          width: 200,
          height: 200,
          child: Stack(fit: StackFit.expand, children: [
            CircularProgressIndicator(
              value: 1 -
                  context.watch<timer_provider>().tempo_secondi /
                      context.watch<timer_provider>().tempo_iniziale_sec,
              strokeWidth: 10,
              backgroundColor: Colors.red,
            ),
            Center(child: buildTime())
          ]));
    }
    if (tempo_secondi == 0 &&
        context.watch<timer_provider>().tempo_secondi > 0) {
      buildTime();
    }
    return Text(
      '0',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50),
    );
  }

  Widget buildTime() {
    return Text(
      '${context.watch<timer_provider>().tempo_secondi}',
      style: TextStyle(
          fontSize: 50, color: Colors.white, fontWeight: FontWeight.w900),
    );
  }
}
