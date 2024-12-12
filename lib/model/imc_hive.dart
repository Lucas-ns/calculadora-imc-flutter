import 'package:hive/hive.dart';

part 'imc_hive.g.dart';

@HiveType(typeId: 1)
class ImcHive extends HiveObject {
  @HiveField(0)
  String nome;

  @HiveField(1)
  double peso;

  @HiveField(2)
  double altura;

  @HiveField(3)
  double imc;

  ImcHive(
      {required this.nome,
      required this.peso,
      required this.altura,
      required this.imc});
}
