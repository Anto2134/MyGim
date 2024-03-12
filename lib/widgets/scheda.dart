class scheda {
  String nome = '';
  int numeroGiorni = 0;
  // Map<String, int> esercizi2nSerie = {};
  // Map<String, List<String>> esercizi2nSerie = {};
  Map<String, List<String>> tab2esercizi = {};
  List<String> tabTitles = [];

  scheda();

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

  List<String> getTab() {
    return this.tabTitles;
  }

  void addTab() {
    final title = 'Tab ${tabTitles.length + 1}';
    tabTitles.add(title);
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
