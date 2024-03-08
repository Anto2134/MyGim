// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class card_allenamento extends StatefulWidget {
  const card_allenamento({super.key});

  @override
  State<card_allenamento> createState() => _card_allenamentoState();
}

class _card_allenamentoState extends State<card_allenamento> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/allenamento');
      },
      child: Card(
        color: Colors.black,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          children: [
            Image.asset('images/allenamento.jpg'),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'NUOVO ALLENAMENTO',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
