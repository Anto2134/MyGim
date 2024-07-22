// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progettomygimnuovo/Pages/AccountSettingsPage.dart';
import 'package:progettomygimnuovo/Pages/ShopPage.dart';
import 'package:http/http.dart' as http;
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
  Widget verifica_tempo() {
    if (context.watch<timer_provider>().tempo_secondi == 0) {
      return Container(
        height: 2,
        color: Colors.black,
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
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
          const SizedBox(width: 6.0),
          Text(
            '${context.watch<timer_provider>().tempo_secondi}',
            style: TextStyle(
              color: coloreNumero(),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchRandomQuote() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.api-ninjas.com/v1/quotes?category=fitness'),
        headers: {
          'X-Api-Key':
              'POy6lJIYMFiNHbfW4qWI2g==S6xYX1PCp3fXDpNc', // Inserisci qui la tua chiave API
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> quoteData = jsonDecode(response.body);
        if (quoteData.isNotEmpty) {
          final String quote = quoteData[0]['quote'];
          final String author = quoteData[0]['author'];
          _showQuoteDialog('$quote\n\n- $author');
        } else {
          print('No quotes found.');
        }
      } else {
        print('Failed to load random quote: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching random quote: $e');
    }
  }

  void _showQuoteDialog(String quote) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Wrap(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  width: 40.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Random Quote',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  quote,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFullScreenMenu() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.shop_2_outlined),
                title: const Text('Shop'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShopPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Account Settings'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccountSettingsPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Logout'),
                onTap: () {
                  _logout();
                },
              )
            ],
          ),
        );
      },
    );
  }

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false);
    } catch (e) {
      print('Errore durante il logout: $e');
      // Mostra un messaggio di errore se necessario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _showFullScreenMenu,
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'MYHOMEGYM',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: _fetchRandomQuote,
              child: const Icon(Icons.format_quote, size: 30.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: verifica_tempo(),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
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
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    card_allenamento(),
                    card_miei_allenamenti(),
                    card_schede(),
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
        child: const Icon(Icons.timer_sharp),
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
