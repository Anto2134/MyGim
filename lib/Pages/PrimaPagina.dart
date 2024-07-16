// // ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:progettomygimnuovo/services/Auth.dart';
// import 'package:provider/provider.dart';

// import '../providers/timer_provider.dart';
// import '../widgets/card_allenamento.dart';
// import '../widgets/card_miei_allenamenti.dart';
// import '../widgets/card_schede.dart';

// class PrimaPagina extends StatefulWidget {
//   const PrimaPagina({super.key});

//   @override
//   State<PrimaPagina> createState() => _PrimaPaginaState();
// }

// class _PrimaPaginaState extends State<PrimaPagina> {
//   Widget verifica_tempo() {
//     if (context.watch<timer_provider>().tempo_secondi == 0)
//       return Container(
//         height: 2,
//         color: Colors.black,
//       );
//     return Text(
//       '${context.watch<timer_provider>().tempo_secondi}',
//       style: TextStyle(
//         color: coloreNumero(),
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }

//   Future<void> signOut() async {
//     Auth().signOut();
//   }

//   Future<void> _showLogoutConfirmationDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // L'utente deve confermare o annullare
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Conferma Logout'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Sei sicuro di voler effettuare il logout?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Annulla'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Chiude il dialogo
//               },
//             ),
//             TextButton(
//               child: Text('Conferma'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Chiude il dialogo
//                 signOut(); // Effettua il logout
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: verifica_tempo(),
//         backgroundColor: Colors.black,
//         centerTitle: true,
//         title: Text(
//           'MYHOMEGYM',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 // signOut();
//                 _showLogoutConfirmationDialog();
//               },
//               icon: Icon(
//                 Icons.logout_outlined,
//                 color: Colors.white,
//               ))
//         ],
//       ),
//       body: Scrollbar(
//         thumbVisibility: true,
//         trackVisibility: true,
//         thickness: 5,
//         child: ListView(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Column(
//                 children: [
//                   const card_allenamento(),
//                   const card_miei_allenamenti(),
//                   const card_schede(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.white,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/orologio');
//         },
//         child: Icon(Icons.timer_sharp),
//       ),
//     );
//   }

//   Color coloreNumero() {
//     if (context.watch<timer_provider>().count_startato == 1) {
//       if (context.watch<timer_provider>().tempo_secondi % 2 != 0 &&
//           context.watch<timer_provider>().tempo_secondi <= 5) {
//         return Colors.red;
//       }
//     }
//     return Colors.white;
//   }
// }
// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/services/Auth.dart';
import 'package:provider/provider.dart';

import '../providers/timer_provider.dart';
import '../widgets/card_allenamento.dart';
import '../widgets/card_miei_allenamenti.dart';
import '../widgets/card_schede.dart';

class PrimaPagina extends StatefulWidget {
  const PrimaPagina({super.key});

  @override
  State<PrimaPagina> createState() => _PrimaPaginaState();
}

class _PrimaPaginaState extends State<PrimaPagina> {
  // Widget verifica_tempo() {
  //   if (context.watch<timer_provider>().tempo_secondi == 0) {
  //     return Container(
  //       height: 2,
  //       color: Colors.black,
  //     );
  //   }
  //   return Text(
  //     '${context.watch<timer_provider>().tempo_secondi}',
  //     style: TextStyle(
  //       color: coloreNumero(),
  //       fontWeight: FontWeight.w600,
  //     ),
  //   );
  // }
  Widget verifica_tempo() {
    if (context.watch<timer_provider>().tempo_secondi == 0) {
      return Container(
        height: 2,
        color: Colors.black,
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer,
            color: coloreNumero(),
            size: 20.0,
          ),
          SizedBox(width: 6.0),
          Text(
            '${context.watch<timer_provider>().tempo_secondi}',
            style: TextStyle(
              color: coloreNumero(),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    Auth().signOut();
  }

  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // L'utente deve confermare o annullare
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Conferma Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Sei sicuro di voler effettuare il logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annulla'),
              onPressed: () {
                Navigator.of(context).pop(); // Chiude il dialogo
              },
            ),
            TextButton(
              child: Text('Conferma'),
              onPressed: () {
                Navigator.of(context).pop(); // Chiude il dialogo
                signOut(); // Effettua il logout
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: verifica_tempo(),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'MYHOMEGYM',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        actions: [
          verifica_tempo(),
          IconButton(
            onPressed: () {
              // signOut();
              _showLogoutConfirmationDialog();
            },
            icon: Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          thickness: 5,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    const card_allenamento(),
                    const card_miei_allenamenti(),
                    const card_schede(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/orologio');
        },
        child: Icon(Icons.timer_sharp),
      ),
    );
  }

  Color coloreNumero() {
    if (context.watch<timer_provider>().count_startato == 1) {
      if (context.watch<timer_provider>().tempo_secondi % 2 != 0 &&
          context.watch<timer_provider>().tempo_secondi <= 5) {
        return Colors.red;
      }
    }
    return Colors.white;
  }
}
