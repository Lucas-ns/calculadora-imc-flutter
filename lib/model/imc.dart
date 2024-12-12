class IMC {
  final String nome;
  final double peso;
  final double altura;
  final double imc;

  IMC(
      {required this.nome,
      required this.peso,
      required this.altura,
      required this.imc});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'altura': altura,
      'peso': peso,
      'imc': imc,
    };
  }

  factory IMC.fromMap(Map<String, dynamic> map) {
    return IMC(
        nome: map['nome'],
        peso: map['peso'],
        altura: map['altura'],
        imc: map['imc']);
  }
}
