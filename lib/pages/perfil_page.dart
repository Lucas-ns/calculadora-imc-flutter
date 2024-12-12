import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _nomeController = TextEditingController();
  final _alturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarPerfil();
  }

  Future<void> _carregarPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    final nome = prefs.getString('nome') ?? '';
    final altura = prefs.getDouble('altura') ?? 0.0;
    setState(() {
      _nomeController.text = nome;
      _alturaController.text = altura > 0 ? altura.toString() : '';
    });
  }

  Future<void> _salvarPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _nomeController.text);
    final altura = double.tryParse(_alturaController.text);

    if (_alturaController.text.isEmpty || _nomeController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Preencher nome e altura")));
      }
      return;
    }

    if (altura != null) {
      await prefs.setDouble('altura', altura);
    }

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _alturaController,
              decoration: const InputDecoration(labelText: 'Altura (m)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: _salvarPerfil, child: const Text('Salvar'))
          ],
        ),
      ),
    ));
  }
}
