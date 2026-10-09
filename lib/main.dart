import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const TelaIMC(),
    );
  }
}

class TelaIMC extends StatefulWidget {
  const TelaIMC({super.key});

  @override
  State<TelaIMC> createState() => _TelaIMCState();
}

class _TelaIMCState extends State<TelaIMC> {
  static const String _resultadoPadrao = 'Resultado';

  final _pesoCtrl = TextEditingController();
  final _alturaCtrl = TextEditingController();
  String _resultado = _resultadoPadrao;

  void _calcularIMC() {
    final peso = double.tryParse(_pesoCtrl.text.replaceAll(',', '.'));
    final altura = double.tryParse(_alturaCtrl.text.replaceAll(',', '.'));

    if (peso == null || altura == null || altura <= 0) {
      setState(() => _resultado = 'Informe peso e altura válidos');
      return;
    }

    final imc = peso / (altura * altura);
    setState(() => _resultado = 'O SEU IMC GORDAO É ${imc.toStringAsFixed(2)}');
  }

  void _limparCampos() {
    _pesoCtrl.clear();
    _alturaCtrl.clear();
    setState(() => _resultado = _resultadoPadrao);
  }

  @override
  void dispose() {
    _pesoCtrl.dispose();
    _alturaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _pesoCtrl,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _alturaCtrl,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Altura (m)',
                  hintText: 'ex.: 1.75',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _calcularIMC,
                      child: const Text('Calcular'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _limparCampos,
                      child: const Text('Limpar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}