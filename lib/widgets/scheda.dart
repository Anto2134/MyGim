class scheda {
  String nome = '';
  int numeroGiorni = 0;
  // Map<String, int> esercizi2nSerie = {};
  // Map<String, List<String>> esercizi2nSerie = {};
  Map<String, List<String>> tab2esercizi = {};
  // Map<String, List<String>> nome2serie = {};
  // Map<String, Map<String, List<String>>> map = {};
  List<String> tabTitles = [];

  scheda();

  // Map<String, List<String>> getNome2serie(){
  //   return this.nome2serie;
  // }

  // Map<String, List<String>>? getMapF(String title){
  //   return map[title];
  // }
  // void setF(Map<String, Map<String, List<String>>> map){
  //   this.map = map;
  // }

  // void setNome2serie(Map<String, List<String>> nome2nserie){
  //   this.nome2serie = nome2nserie;
  // }
  void setNome(String nome) {
    this.nome = nome;
  }

  void setGiorni(int numeroGiorni) {
    this.numeroGiorni = numeroGiorni;
  }

  void setTab(List<String> tabTitles) {
    this.tabTitles = tabTitles;
  }

  // void setMap(Map<String, int> esercizi2nSerie) {
  //   this.esercizi2nSerie = esercizi2nSerie;
  // }

  void setMap(Map<String, List<String>> tab2esercizi) {
    this.tab2esercizi = tab2esercizi;
  }

  // void setData(String tab, String esercizio, String serie){
  //   nome2serie[esercizio]?.add(serie);
  //   map[tab] = nome2serie;
  // }

  void addDati(String tab, String dati){
    tab2esercizi[tab]?.add(dati);
  }

  List<String> getTab() {
    return this.tabTitles;
  }

  void addTab(String title) {
    // final title = 'Tab ${tabTitles.length + 1}';
    tabTitles.add(title);
    tab2esercizi[title] = [];
  }

  String getNome() {
    return this.nome;
  }

  int getGiorni() {
    return this.numeroGiorni;
  }

  Map<String, List<String>> getMap() {
    return this.tab2esercizi;
  }

  factory scheda.fromJson(Map<String, dynamic> json) {
    return scheda()
      ..nome = json['nome']
      ..numeroGiorni = json['numeroGiorni']
      // ..esercizi2nSerie = json['esercizi2nSerie'];
      ..tab2esercizi = json['esercizi2nSerie'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'numeroGiorni': numeroGiorni,
      // 'esercizi2nSerie' : esercizi2nSerie,
      'esercizi2nSerie': tab2esercizi,
    };
  }
}
