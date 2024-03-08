// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';


class card_miei_allenamenti extends StatefulWidget {
  const card_miei_allenamenti({super.key});

  @override
  State<card_miei_allenamenti> createState() => _card_miei_allenamentiState();
}

class _card_miei_allenamentiState extends State<card_miei_allenamenti> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'miei_allenamenti');
      },
      child: Card(
        color: Colors.black,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          children: [
            Image.asset('images/allenamenti.jpg'),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'I MIEI ALLENAMENTI',
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
