class scheda {
  String nome = '';
  int numeroGiorni = 0;
  Map<String, int> esercizi2nSerie = {};

  scheda();

  void setNome(String nome) {
    this.nome = nome;
  }

  void setGiorni(int numeroGiorni) {
    this.numeroGiorni = numeroGiorni;
  }

  void setMap(Map<String, int> esercizi2nSerie) {
    this.esercizi2nSerie = esercizi2nSerie;
  }

  String getNome() {
    return this.nome;
  }

  int getGiorni() {
    return this.numeroGiorni;
  }

  Map<String, int> getMap() {
    return this.esercizi2nSerie;
  }

  factory scheda.fromJson(Map<String, dynamic> json){
    return scheda()
    ..nome = json['nome']
    ..numeroGiorni = json['numeroGiorni']
    ..esercizi2nSerie = json['esercizi2nSerie'];
  }

  Map<String, dynamic> toJson(){
    return {
      'nome' : nome,
      'numeroGiorni' : numeroGiorni,
      'esercizi2nSerie' : esercizi2nSerie,
    };
  }
}
