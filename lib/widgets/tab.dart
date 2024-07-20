// ignore_for_file: camel_case_types, prefer_initializing_formals

class tab {
  Map<String, List<String>> ese2serie = {};
  String titolo = '';

  tab(String titolo) {
    this.titolo = titolo;
  }

  void setTitolo(String titolo) {
    this.titolo = titolo;
  }

  String getTitolo() {
    return titolo;
  }

  Map<String, List<String>> getMap() {
    return ese2serie;
  }

  void setMap(Map<String, List<String>> map) {
    ese2serie = map;
  }

  void setData(String esercizio, String serie) {
    ese2serie[esercizio] = [];
    ese2serie[esercizio]!.add(serie);
  }
}
