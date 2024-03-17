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
  // List<String> schede = [];
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

  void addTab(scheda card) {
    final title = 'Tab ${tabTitles.length + 1}';
    // tabTitles.add(title);
    // card.addTab();
    tab2esercizio[title] = [];
    // card.setTab(tabTitles);
    // tabTitles = [];
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
              // nuova.setData(tab, ese);
              nuova.setNome(textFieldController.text);
              // nuova.setMap(tab2esercizio);
              // nuova.setTab(tabTitles);
              // nuova.setF(map);
              // nuova.setNome2serie(nome2esee);
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
              textFieldController.text = "";
              Navigator.pop(context!);
            },
            icon: Icon(Icons.done))
      ],
    );
  }

  void azzera() {
    textFieldControllerEs.text = '';
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
              // esercizio.add(textFieldControllerEs.text);
              // tab2esercizio[titolo] = esercizio;
              // tab2esercizio[titolo]?.add(textFieldControllerEs.text);
              // scheda.addDati(titolo, textFieldControllerEs.text);
              // List<String> app = [];
              // app.add(textFieldControllerEs.text);
              // ese2serie[textFieldControllerEs.text] = app;
              print('object' + ese2serie.toString());
              // scheda.setData(titolo, textFieldControllerEs.text,
              // textFieldControllerSerie.text);
              // scheda.setDati(titolo, ese2serie);
              scheda.addDati(titolo, textFieldControllerEs.text,
                  textFieldControllerSerie.text);
              // app.clear();
              // scheda.setMap();
              // scheda.addDati(titolo, textFieldControllerSerie.text);
              // scheda.setMap(tab2esercizio);
              // scheda.setTab(tabTitles);
              // nuova.setMap(tab2esercizio);
              notifyListeners();
              // app.clear();
              Navigator.pop(context!);
              azzera();
              // tab2esercizio = {};
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
              // scheda.reset(textFieldControllerTab.text);
              // scheda.setData(textFieldControllerTab.text, "", "");
              // scheda.setF({});
              // scheda.map[textFieldControllerTab.text] = {};
              // scheda.nome2serie = {};
              notifyListeners();
              Navigator.pop(context!);
              textFieldControllerTab.text = "";
              // azzera();
            },
            icon: Icon(Icons.close))
      ],
    );
  }
}
