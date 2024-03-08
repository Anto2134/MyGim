// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class card_schede extends StatefulWidget {
  const card_schede({super.key});

  @override
  State<card_schede> createState() => _card_schedeState();
}

class _card_schedeState extends State<card_schede> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          Image.asset('images/schede.jpg'),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'LE MIE SCHEDE',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
