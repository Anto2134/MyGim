// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names, unnecessary_this

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/Pages/DataStorageDemo.dart';
import 'package:progettomygimnuovo/Pages/PaginaMieiAllenamenti.dart';
import 'package:progettomygimnuovo/providers/nuovaSessione_provider.dart';
import 'package:progettomygimnuovo/widgets/Widget_New_Training.dart';
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

  bool get isSessionActive => _isSessionActive;
  DateTime get sessionStartTime => _sessionStartTime;
  DateTime get sessionEndTime => _sessionEndTime;

  nuovoAllenamento_provider(){
    loadData();
  }

  void startSession() {
    _isSessionActive = true;
    _sessionStartTime = DateTime.now();
    // nuovaSessione_provider().addItem(sessionStartTime.weekday.toString());
    addItem(sessionStartTime.toString());
    nSessioni++;
    // PaginaMieiAllenamenti.incrementa();
    notifyListeners();
  }

    Future<void> rimuovi(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // date = prefs.getStringList('dati') ?? [];
    date.remove(key);
    prefs.remove(key);
    saveData();
  }

  void endSession() {
    _isSessionActive = false;
    _sessionEndTime = DateTime.now();
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

  void dispose() {
    // Esegui la pulizia della sessione qui
    final DateTime sessionEndTime = DateTime.now();
    final Duration sessionDuration =
        sessionEndTime.difference(_sessionStartTime);
    print('Fine della sessione: $sessionEndTime');
    print('Durata della sessione: $sessionDuration');
    // super.dispose();
  }

  void setNEsercizi(int n) {
    this.nEsercizi = n;
  }

  void setContext(BuildContext context) {
    this.context_p = context;
  }

  AlertDialog generaForm() {
    return AlertDialog(
      scrollable: true,
      title: const Text('Nuovo esercizio'),
      content: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: textFieldController,
                decoration: const InputDecoration(labelText: 'Esercizio:'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Scrivi il nome dell'esercizio";
                  }
                  notifyListeners();
                  return null;
                },
              ),
              Column(
                children: [
                  TextFormField(
                    controller: textFieldControllerNumero,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'Numero di serie:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Scrivi il numero di serie da eseguire";
                      }
                      notifyListeners();
                      return null;
                    },
                  ),
                  ...formFields,
                ],
              ),
            ],
          )),
      actions: <Widget>[
        IconButton(
            onPressed: () async {
              nomeEsercizio = textFieldController.text;
              print(nomeEsercizio + "Nomegiusto");
              toccato++;
              int i = 0;
              print(toccato);
              if (toccato <= 1) {
                if (formKey.currentState!.validate()) {
                  int? parsedNumber =
                      int.tryParse(textFieldControllerNumero.text);
                  if (parsedNumber != null) {
                    numeroSerie = parsedNumber;
                  }
                }
                // if(numeroSerie != 0 && nomeEsercizio != null){
                //   await saveData(nomeEsercizio);
                // }
                for (i = 0; i < numeroSerie; i++) {
                  controllers.add(TextEditingController());
                  notifyListeners();
                }
                for (i = 0; i < numeroSerie; i++) {
                  for (TextEditingController c in controllers) {
                    formFields.add(TextFormField(
                      controller: c,
                      decoration: const InputDecoration(
                          labelText: "nuova riga",
                          hintText: 'scrivi carico * numero di ripetizioni'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          formFields.length = 0;
                          controllers.length = 0;
                          notifyListeners();
                          return 'scrivi carico * numero di ripetizioni';
                        }
                        print('VALORE: $value');
                        return null;
                      },
                    ));
                    notifyListeners();
                  }
                }
                // DataStorageDemo(
                // savedData: nomeEsercizio,
                // );
                print(nomeEsercizio + "AOOOO");
                formFields.length = numeroSerie;
                notifyListeners();
              }
            },
            icon: const Icon(Icons.done)),
        TextButton(
            onPressed: () {
              toccato = 0;
              List<String> dati = [];
              for (int i = 0; i < controllers.length; i++) {
                dati.add(controllers[i].text);
              }
              nomeEsercizio = textFieldController.text;
              // DataStorageDemo(
              // savedData: nomeEsercizio,
              // );

              nome2nserie[nomeEsercizio] = dati;
              if (formKey.currentState!.validate()) {
                print('testo in ingresso: ${textFieldController.text}');
                Navigator.of(context_p!).pop();
                lista();
                controllers = [];
              }
              notifyListeners();
            },
            child: const Text('chiudi'))
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