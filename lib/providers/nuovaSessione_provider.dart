import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/widgets/Widget_New_Training.dart';
import 'package:shared_preferences/shared_preferences.dart';

class nuovaSessione_provider with ChangeNotifier {
  List<String> dati = [];
  String orario = "";
  Widget? list;
  int count = 0;

  nuovaSessione_provider() {
    loadData();
  }

  // Funzione per caricare i dati da SharedPreferences
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dati = prefs.getStringList('dati') ?? [];
    lista();
    notifyListeners();
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('dati', dati);
  }

  // Funzione per aggiungere un elemento all'array e salvarlo in SharedPreferences
  // Future<void> addItem(String item) async {
  //   dati.add(item);
  //   orario = item;
  //   saveData();
  //   notifyListeners();
  // } 
  void addItem(String item){
    dati.add(item);
    count++;
    saveData();
    notifyListeners();
  }

  Future<void> rimuovi() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  // Funzione per rimuovere un elemento dall'array e aggiornare SharedPreferences
  Future<void> removeItem(String item) async {
    dati.remove(item);
    await saveData();
    notifyListeners();
  }

  Widget? lista() {
    list = Widget_New_Training(ora: dati);
    return list;
  }
}
