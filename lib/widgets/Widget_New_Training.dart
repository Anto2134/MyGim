// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Widget_New_Training extends StatefulWidget {
  // Widget_New_Training({required this.category});
  Widget_New_Training({required this.ora});
  final List<String> ora;

  @override
  State<Widget_New_Training> createState() => Widget_New_TrainingState();
}

class Widget_New_TrainingState extends State<Widget_New_Training> {
  String data = "";
  List<String> dati = [];

  @override
  void initState() {
    super.initState();
    // loadData();
  }

  // Future<void> saveData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setStringList('dati', dati);
  // }

  // Future<void> loadData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     dati = prefs.getStringList('dati') ?? [];
  //   });
  // }

  // void addItem(String newItem) {
  //   setState(() {
  //     dati.add(newItem);
  //     saveData();
  //   });
  // }

  Widget build(BuildContext context) {
    return lista();
  }

  Widget lista() {
    return ListView.builder(
      itemCount: widget.ora.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('ciao'),
          ),
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     child: ListTile(
  //       title: Text('ciao'),
  //       trailing: Text('$data'),
  //       // onTap: () {
  //       //   Navigator.push(
  //       //     context,
  //       //     MaterialPageRoute(
  //       //       builder: (context) => SubCategoryPage(category: widget.category),
  //       //     ),
  //       //   );
  //       // },
  //     ),
  //   );
  // }
}
