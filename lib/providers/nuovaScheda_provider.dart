// ignore_for_file: camel_case_types, unnecessary_new, unused_local_variable, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/scheda.dart';

class nuovaScheda_provider with ChangeNotifier {
  TextEditingController textFieldController = TextEditingController();
  TextEditingController textFieldControllerEs = TextEditingController();
  TextEditingController textFieldControllerNumero = TextEditingController();
  // List<String> schede = [];
  BuildContext? context;
  List<scheda> schede = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String nome = '';
  String titolo = '';
  Map<String, List<String>> tab2esercizio = {};
  List<String> esercizio = [];
  List<String> tabTitles = [];
  


  void addTab() {
    final title = 'Tab ${tabTitles.length + 1}';
    tabTitles.add(title);
    tab2esercizio[title] = [];
    notifyListeners();
  }

  void setContext(BuildContext context) {
    this.context = context;
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('schede', jsonEncode(schede));
  }

  Future<List<scheda>> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? listaDatiJson = prefs.getString('schede');
    List<scheda> listaDati = (jsonDecode(listaDatiJson!) as List)
        .map((data) => scheda.fromJson(data))
        .toList();
    return listaDati;
  }

  AlertDialog generaForm() {
    scheda nuova = scheda();
    return AlertDialog(
      scrollable: true,
      title: const Text('Nuova scheda'),
      content: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: textFieldController,
                decoration:
                    InputDecoration(labelText: 'Scrivi il nome della scheda'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Scrivi il nome della scheda';
                  }
                  notifyListeners();
                  return null;
                },
              ),
              TextFormField(
                controller: textFieldControllerNumero,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Scrivi il numero di giorni';
                  }
                  notifyListeners();
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'In quanti giorni vuoi dividere la scheda?'),
              ),
            ],
          )),
      actions: [
        IconButton(
            onPressed: () {
              nuova.setNome(textFieldController.text);
              schede.add(nuova);
              if (formKey.currentState!.validate()) {
                int? parsedNumber =
                    int.tryParse(textFieldControllerNumero.text);
                if (parsedNumber != null) {
                  nuova.setGiorni(parsedNumber);
                }
              }
              notifyListeners();
              // schede.add(textFieldController.text);
              Navigator.pop(context!);
            },
            icon: Icon(Icons.done))
      ],
    );
  }

  AlertDialog generaForm2(String titolo) {
    return AlertDialog(
      scrollable: true,
      content: Form(
          child: Column(
        children: [
          TextFormField(
            controller: textFieldControllerEs,
            decoration: InputDecoration(labelText: 'Scrivi nome esercizio'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'scrivi il nome dell* esercizio';
              }
              notifyListeners();
              return null;
            },
          )
        ],
      )),
      actions: [
        IconButton(
            onPressed: () {
              esercizio.add(textFieldControllerEs.text);
              // tab2esercizio[titolo] = esercizio;
              tab2esercizio[titolo]?.add(textFieldControllerEs.text);
              notifyListeners();
              Navigator.pop(context!);
            },
            icon: Icon(Icons.close))
      ],
    );
  }
}
