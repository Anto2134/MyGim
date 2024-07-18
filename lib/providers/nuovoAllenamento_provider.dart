// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names, unnecessary_this

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/widgets/card_nuovo_allenamento.dart';
import 'package:shared_preferences/shared_preferences.dart';

class nuovoAllenamento_provider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textFieldController = TextEditingController();
  TextEditingController textFieldControllerNumero = TextEditingController();
  int numeroSerie = 0;
  String nomeEsercizio = "";
  List<Widget> formFields = [];
  Map<String, List<String>> nome2nserie = {};
  BuildContext? context_p;
  Widget? list_v;
  int nEsercizi = 0;
  int toccato = 0;
  List<TextEditingController> controllers = [];
  bool _isSessionActive = false;
  late DateTime _sessionStartTime;
  late DateTime _sessionEndTime;
  int nSessioni = 0;
  List<String> date = [];
  List<String> date2 = [];
  Map<String, Map<String, List<String>>> orario2ese = {};
  String orario = '';

  bool get isSessionActive => _isSessionActive;
  DateTime get sessionStartTime => _sessionStartTime;
  DateTime get sessionEndTime => _sessionEndTime;

  nuovoAllenamento_provider() {
    loadMap();
  }

  void startSession() {
    _isSessionActive = true;
    _sessionStartTime = DateTime.now();
    orario = sessionStartTime.toString();
    addItem(sessionStartTime.toString());
    nSessioni++;
    notifyListeners();
  }

  Future<void> saveMap(Map<String, Map<String, List<String>>> map) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(map);
    prefs.setString('map', jsonString);
  }

  // Carica la mappa dalle Shared Preferences
  Future<Map<String, Map<String, List<String>>>> loadMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('map');
    if (jsonString != null) {
      // Decodifica la stringa JSON e casta le liste al tipo corretto
      Map<String, dynamic> decodedMap = jsonDecode(jsonString);
      Map<String, Map<String, List<String>>> resultMap = {};
      decodedMap.forEach((key, value) {
        Map<String, dynamic> innerMap = value.cast<String, dynamic>();
        Map<String, List<String>> convertedInnerMap = {};
        innerMap.forEach((innerKey, innerValue) {
          convertedInnerMap[innerKey] = List<String>.from(innerValue);
        });
        resultMap[key] = convertedInnerMap;
      });
      for (String s in resultMap.keys) {
        date2.add(s);
      }
      orario2ese = resultMap;
      return resultMap;
    } else {
      return {}; // Ritorna una mappa vuota se non ci sono dati salvati
    }
  }

  // Elimina la mappa salvata
  Future<void> deleteMap(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    date2.remove(key);
    orario2ese.remove(key);
    prefs.remove('map');
    saveMap(orario2ese);
  }

  Future<void> rimuovi(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    date.remove(key);
    prefs.remove(key);
    saveData();
  }

  void endSession() {
    _isSessionActive = false;
    _sessionEndTime = DateTime.now();
    nome2nserie = {};
    lista();
    // dispose();

    notifyListeners();
  }

  // Funzione per caricare i dati da SharedPreferences
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    date = prefs.getStringList('dati') ?? [];
    lista();
    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('dati', date);
  }

  void addItem(newItem) {
    date.add(newItem);
    saveData();
  }

  void setNEsercizi(int n) {
    this.nEsercizi = n;
  }

  void setContext(BuildContext context) {
    this.context_p = context;
  }

  // AlertDialog generaForm() {
  //   return AlertDialog(
  //     scrollable: true,
  //     title: const Text('Nuovo esercizio'),
  //     content: Form(
  //         key: formKey,
  //         child: Column(
  //           children: [
  //             TextFormField(
  //               controller: textFieldController,
  //               decoration: const InputDecoration(labelText: 'Esercizio:'),
  //               validator: (value) {
  //                 if (value!.isEmpty) {
  //                   return "Scrivi il nome dell'esercizio";
  //                 }
  //                 notifyListeners();
  //                 return null;
  //               },
  //             ),
  //             Column(
  //               children: [
  //                 TextFormField(
  //                   controller: textFieldControllerNumero,
  //                   keyboardType: TextInputType.number,
  //                   decoration:
  //                       const InputDecoration(labelText: 'Numero di serie:'),
  //                   validator: (value) {
  //                     if (value!.isEmpty) {
  //                       return "Scrivi il numero di serie da eseguire";
  //                     }
  //                     notifyListeners();
  //                     return null;
  //                   },
  //                 ),
  //                 ...formFields,
  //               ],
  //             ),
  //           ],
  //         )),
  //     actions: <Widget>[
  //       IconButton(
  //           onPressed: () async {
  //             nomeEsercizio = textFieldController.text;
  //             print("${nomeEsercizio}Nomegiusto");
  //             toccato++;
  //             int i = 0;
  //             print(toccato);
  //             if (toccato <= 1) {
  //               if (formKey.currentState!.validate()) {
  //                 int? parsedNumber =
  //                     int.tryParse(textFieldControllerNumero.text);
  //                 if (parsedNumber != null) {
  //                   numeroSerie = parsedNumber;
  //                 }
  //               }
  //               for (i = 0; i < numeroSerie; i++) {
  //                 controllers.add(TextEditingController());
  //                 notifyListeners();
  //               }
  //               for (i = 0; i < numeroSerie; i++) {
  //                 for (TextEditingController c in controllers) {
  //                   formFields.add(TextFormField(
  //                     controller: c,
  //                     decoration: const InputDecoration(
  //                         labelText: "nuova riga",
  //                         hintText: 'scrivi carico * numero di ripetizioni'),
  //                     validator: (value) {
  //                       if (value!.isEmpty) {
  //                         formFields.length = 0;
  //                         controllers.length = 0;
  //                         notifyListeners();
  //                         return 'scrivi carico * numero di ripetizioni';
  //                       }
  //                       print('VALORE: $value');
  //                       return null;
  //                     },
  //                   ));
  //                   notifyListeners();
  //                 }
  //               }
  //               print(nomeEsercizio + "AOOOO");
  //               formFields.length = numeroSerie;
  //               notifyListeners();
  //             }
  //           },
  //           icon: const Icon(Icons.done)),
  //       TextButton(
  //           onPressed: () {
  //             toccato = 0;
  //             List<String> dati = [];
  //             for (int i = 0; i < controllers.length; i++) {
  //               dati.add(controllers[i].text);
  //             }
  //             nomeEsercizio = textFieldController.text;
  //             nome2nserie[nomeEsercizio] = dati;
  //             if (_isSessionActive) {
  //               orario2ese[orario] = nome2nserie;
  //               saveMap(orario2ese);
  //             }
  //             if (formKey.currentState!.validate()) {
  //               print('testo in ingresso: ${textFieldController.text}');
  //               Navigator.of(context_p!).pop();
  //               lista();
  //               controllers = [];
  //             }
  //             notifyListeners();
  //           },
  //           child: const Text('chiudi'))
  //     ],
  //   );
  // }
  AlertDialog generaForm() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        'Nuovo esercizio',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: textFieldController,
                decoration: InputDecoration(
                  labelText: 'Esercizio',
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Scrivi il nome dell'esercizio";
                  }
                  notifyListeners();
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: textFieldControllerNumero,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Numero di serie',
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Scrivi il numero di serie da eseguire";
                  }
                  notifyListeners();
                  return null;
                },
              ),
              SizedBox(height: 20),
              ...formFields,
            ],
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.done, color: Colors.green),
          onPressed: () async {
            nomeEsercizio = textFieldController.text;
            toccato++;
            if (toccato <= 1) {
              if (formKey.currentState!.validate()) {
                int? parsedNumber =
                    int.tryParse(textFieldControllerNumero.text);
                if (parsedNumber != null) {
                  numeroSerie = parsedNumber;
                }
              }
              for (int i = 0; i < numeroSerie; i++) {
                controllers.add(TextEditingController());
                notifyListeners();
              }
              for (int i = 0; i < numeroSerie; i++) {
                for (TextEditingController c in controllers) {
                  formFields.add(TextFormField(
                    controller: c,
                    decoration: InputDecoration(
                      labelText: "nuova riga",
                      hintText: 'scrivi carico * numero di ripetizioni',
                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        formFields.length = 0;
                        controllers.length = 0;
                        notifyListeners();
                        return 'scrivi carico * numero di ripetizioni';
                      }
                      return null;
                    },
                  ));
                  notifyListeners();
                }
              }
              formFields.length = numeroSerie;
              notifyListeners();
            }
          },
        ),
        TextButton(
          onPressed: () {
            toccato = 0;
            List<String> dati = [];
            for (int i = 0; i < controllers.length; i++) {
              dati.add(controllers[i].text);
            }
            nomeEsercizio = textFieldController.text;
            nome2nserie[nomeEsercizio] = dati;
            if (_isSessionActive) {
              orario2ese[orario] = nome2nserie;
              saveMap(orario2ese);
            }
            if (formKey.currentState!.validate()) {
              Navigator.of(context_p!).pop();
              lista();
              controllers = [];
            }
            notifyListeners();
          },
          child: const Text(
            'Chiudi',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget? lista() {
    list_v = card_nuovo_allenamento(nome2nserie: nome2nserie);
    return list_v;
  }

  void azzera() {
    textFieldController.text = '';
    textFieldControllerNumero.text = '';
    formFields.length = 0;
    notifyListeners();
  }
}

//Quando faccio dispose devo passare tutti i dati che ho preso durante la sessione alla pagina i miei allenamenti 