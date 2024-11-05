import 'package:flutter/material.dart';
import 'package:imc_calculator/model/imc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final List<IMC> _imcList = [];

  void calcularIMC() {
    double peso = double.tryParse(_pesoController.text) ?? 0;
    double altura = double.tryParse(_alturaController.text) ?? 0;

    if (peso > 0 && altura > 0) {
      IMC novoIMC = IMC(peso: peso, altura: altura);
      setState(() {
        _imcList.add(novoIMC);
      });
      _pesoController.clear();
      _alturaController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Por favor, insira valores válidos de peso e altura.")));
    }
  }

  void remover(int index) {
    setState(() {
      _imcList.removeAt(index);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Peso (kg)"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Altura (m)"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  calcularIMC();
                },
                child: Text("Calcular")),
            const SizedBox(
              height: 40,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _imcList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_imcList[index].formatarImc()),
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
