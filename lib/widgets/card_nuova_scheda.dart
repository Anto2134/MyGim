// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/Pages/PaginaNuovaScheda.dart';

import 'scheda.dart';

class card_nuova_scheda extends StatefulWidget {
  final scheda card;
  const card_nuova_scheda({super.key, required this.card});

  @override
  State<card_nuova_scheda> createState() => card_nuova_schedaState();
}

class card_nuova_schedaState extends State<card_nuova_scheda> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return PaginaNuovaScheda(card: widget.card);
          },
        ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(color: Colors.white, width: 2)),
        color: Colors.amberAccent[400],
        child: ListTile(
          title: Text(
            widget.card.getNome(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
