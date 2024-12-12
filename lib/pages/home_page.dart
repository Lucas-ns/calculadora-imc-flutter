import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imc_calculator/model/imc_hive.dart';
import 'package:imc_calculator/pages/perfil_page.dart';
import 'package:imc_calculator/service/calcular_imc.dart';
import 'package:imc_calculator/shared/widgets/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  List<ImcHive> _imcList = [];

  double? _altura;
  String? _nome;

  @override
  void initState() {
    super.initState();
    _carregarPerfil();
    _carregarHistorico();
  }

  Future<void> _carregarPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString('nome');
      _altura = prefs.getDouble('altura');
    });
  }

  Future<void> _carregarHistorico() async {
    final box = Hive.box<ImcHive>('historico_imc');
    setState(() {
      _imcList = box.values.toList();
    });
    // final prefs = await SharedPreferences.getInstance();
    // final dataString = prefs.getString('historico_imc');
    // if (dataString != null) {
    //   final List<dynamic> jsonList = jsonDecode(dataString);
    //   final List<IMC> historicoCarregado =
    //       jsonList.map((e) => IMC.fromMap(e)).toList();
    //   setState(() {
    //     _imcList = historicoCarregado;
    //   });
    // }
  }

  // Future<void> _salvarHistorico() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final jsonList = _imcList.map((e) => e.toMap()).toList();
  //   prefs.setString('historico_imc', jsonEncode(jsonList));
  // }

  void calcularIMC() {
    final peso = double.tryParse(_pesoController.text);

    if (_altura != null &&
        _altura! > 0 &&
        _nome != null &&
        _nome!.isNotEmpty &&
        peso != null) {
      final imc = CalcularImc.calcularIMC(peso, _altura!);
      final data =
          ImcHive(nome: _nome!, peso: peso, altura: _altura!, imc: imc);

      final box = Hive.box<ImcHive>('historico_imc');
      box.add(data);

      setState(() {
        _imcList = box.values.toList().reversed.toList();
      });

      // setState(() {
      //   _imcList.insert(0, data);
      // });
      // _salvarHistorico();
      FocusScope.of(context).unfocus();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Por favor, insira os valores válidos.")));
    }

    _pesoController.text = "";
  }

  void remover(int index) {
    final box = Hive.box<ImcHive>('historico_imc');
    box.deleteAt(index);
    setState(() {
      _imcList = box.values.toList().reversed.toList();
    });
  }

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String nomeExibicao =
        _nome != null && _nome!.isNotEmpty ? _nome! : 'Usuário';
    String alturaExibicao =
        _altura != null && _altura! > 0 ? '$_altura m' : 'N/D';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: CustomDrawer(
        onProfileTap: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PerfilPage()));

          if (result == true) {
            await _carregarPerfil();
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nome: $nomeExibicao',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Altura: $alturaExibicao',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Peso (kg)"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  calcularIMC();
                },
                child: const Text("Calcular IMC")),
            const SizedBox(
              height: 40,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _imcList.length,
              itemBuilder: (context, index) {
                final item = _imcList[index];
                return ListTile(
                  title: Text(
                      '${item.nome} - IMC: ${item.imc.toStringAsFixed(2)}'),
                  subtitle: Text(
                      'Classificação: ${CalcularImc.getClassificacaoImc(item.imc)}\n'
                      'Peso: ${item.peso} kg | Altura: ${item.altura} m'),
                  trailing: IconButton(
                      onPressed: () {
                        remover(index);
                      },
                      icon: const Icon(Icons.delete)),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
