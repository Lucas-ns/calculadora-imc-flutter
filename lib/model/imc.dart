class IMC {
  final double _peso;
  final double _altura;
  final double _imc;

  IMC({required double peso, required double altura})
      : _peso = peso,
        _altura = altura,
        _imc = peso / (altura * altura);

  double get peso => _peso;
  double get altura => _altura;
  double get imc => _imc;

  String formatarImc() {
    String classificacao = "";
    if (_imc < 16) {
      classificacao = "Magreza grave";
    } else if (_imc < 17) {
      classificacao = "Magreza moderada";
    } else if (_imc < 18.5) {
      classificacao = "Magreza leve";
    } else if (_imc < 25) {
      classificacao = "Saudável";
    } else if (_imc < 30) {
      classificacao = "Sobrepeso";
    } else if (_imc < 35) {
      classificacao = "Obesidade Grau I";
    } else if (_imc < 40) {
      classificacao = "Obesidade Grau II (severa)";
    } else {
      classificacao = "Obesidade Grau III (mórbida)";
    }

    return 'Peso: ${_peso.toStringAsFixed(1)} kg, Altura: ${_altura.toString()} m, IMC: ${_imc.toStringAsFixed(2)}, Classificação: $classificacao';
  }
}
