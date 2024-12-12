import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imc_calculator/model/imc_hive.dart';
import 'package:imc_calculator/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ImcHiveAdapter());

  await Hive.openBox<ImcHive>('historico_imc');

  runApp(const MyApp());
}
