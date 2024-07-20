import 'package:flutter/material.dart';

class card_nuovo_allenamento extends StatefulWidget {
  final Map<String, List<String>> nome2nserie;

  const card_nuovo_allenamento({super.key, required this.nome2nserie});

  @override
  State<card_nuovo_allenamento> createState() => _card_nuovo_allenamentoState();
}

class _card_nuovo_allenamentoState extends State<card_nuovo_allenamento> {
  @override
  Widget build(BuildContext context) {
    final List<String> chiavi = widget.nome2nserie.keys.toList();

    return ListView.builder(
      itemCount: chiavi.length,
      itemBuilder: (context, index) {
        final String chiave = chiavi[index];
        final List<String>? list = widget.nome2nserie[chiave];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  'Esercizio: $chiave',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: list != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: list.asMap().entries.map((entry) {
                          int serieNumber = entry.key + 1;
                          String item = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Serie $serieNumber: $item',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
