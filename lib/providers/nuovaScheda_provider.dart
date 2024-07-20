// ignore_for_file: camel_case_types, unnecessary_new, unused_local_variable, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/widgets/scheda.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/scheda.dart';
import '../widgets/tab.dart';

class nuovaScheda_provider with ChangeNotifier {
  TextEditingController textFieldController = TextEditingController();
  TextEditingController textFieldControllerEs = TextEditingController();
  TextEditingController textFieldControllerTab = TextEditingController();
  TextEditingController textFieldControllerNumero = TextEditingController();
  TextEditingController textFieldControllerSerie = TextEditingController();
  BuildContext? context;
  List<scheda> schede = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String nome = '';
  String titolo = '';
  Map<String, List<String>> tab2esercizio = {};
  Map<String, Map<String, List<String>>> map = {};
  Map<String, List<String>> nome2esee = {};
  Map<String, List<String>> ese2serie = {};
  List<String> esercizio = [];
  List<String> tabTitles = [];
  List<tab> tabs = [];
  Map<scheda, List<tab>> scheda2tabs = {};

  void removeScheda(scheda schedaDaRimuovere) {
    schede.remove(schedaDaRimuovere);
    notifyListeners();
  }

  void addTab(scheda card) {
    final title = 'Tab ${tabTitles.length + 1}';
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
            ],
          )),
      actions: [
        IconButton(
            onPressed: () {
              tab2esercizio = {};
              tabTitles = [];
              map = {};
              nome2esee = {};
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
              textFieldController.text = "";
              Navigator.pop(context!);
            },
            icon: Icon(Icons.done))
      ],
    );
  }

  void azzera() {
    textFieldControllerEs.text = '';
    textFieldControllerSerie.text = '';
  }

  AlertDialog generaForm2(String titolo, scheda scheda) {
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
          ),
          TextFormField(
            controller: textFieldControllerSerie,
            decoration: InputDecoration(labelText: 'quante serie vuoi fare?'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'scrivi numero serie';
              }
              notifyListeners();
              return null;
            },
          ),
        ],
      )),
      actions: [
        IconButton(
            onPressed: () {
              print('object' + ese2serie.toString());
              scheda.addDati(titolo, textFieldControllerEs.text,
                  textFieldControllerSerie.text);
              notifyListeners();
              Navigator.pop(context!);
              azzera();
            },
            icon: Icon(Icons.close))
      ],
    );
  }

  AlertDialog generaFormTab(scheda scheda) {
    return AlertDialog(
      scrollable: true,
      content: Form(
          child: TextFormField(
        controller: textFieldControllerTab,
        decoration: InputDecoration(
          labelText: 'gruppi da allenare',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'scrivi il nome dei gruppi che vuoi allenare';
          }
          notifyListeners();
          return null;
        },
      )),
      actions: [
        IconButton(
            onPressed: () {
              scheda.addNewTab(textFieldControllerTab.text);
              ese2serie.clear();
              notifyListeners();
              Navigator.pop(context!);
              textFieldControllerTab.text = "";
            },
            icon: Icon(Icons.close))
      ],
    );
  }
}
