import 'package:flutter/material.dart';

class PantallaJuego extends StatefulWidget { 
  const PantallaJuego({super.key}); 

  @override
  State<PantallaJuego> createState() => _PantallaJuegoState();
}

class _PantallaJuegoState extends State<PantallaJuego> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numeroCtrl = TextEditingController();

  final int _numeroSecreto = 12; // Número secreto definido
  int _intentos = 0;
  String _mensajeFeedback = '';
  bool _haGanado = false;

  @override
  void dispose() {
    _numeroCtrl.dispose();
    super.dispose();
  }

  void _comprobarRespuesta() {
    if (_formKey.currentState!.validate()) {
      final numeroIngresado = int.parse(_numeroCtrl.text.trim());

      setState(() {
        _intentos++;
        if (numeroIngresado < _numeroSecreto) {
          _mensajeFeedback = 'Intenta con un número mayor';
        } else if (numeroIngresado > _numeroSecreto) {
          _mensajeFeedback = 'Intenta con un número menor';
        } else {
          _haGanado = true;
          _mensajeFeedback = '¡Felicitaciones! Has adivinado el número.';
        }
      });
    }
  }

  void _reiniciarJuego() {
    setState(() {
      _intentos = 0;
      _mensajeFeedback = '';
      _haGanado = false;
      _numeroCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Adivina el número',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'El número secreto está entre 1 y 20.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _numeroCtrl,
                enabled: !_haGanado,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Ingresa un número (1 - 20)',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'El campo no puede estar vacío';
                  }
                  final num = int.tryParse(val.trim());
                  if (num == null) {
                    return 'Debe ingresar un número entero';
                  }
                  if (num < 1 || num > 20) {
                    return 'El número debe estar entre 1 y 20';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _haGanado ? null : _comprobarRespuesta,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Comprobar'),
              ),

              const SizedBox(height: 24),
              Text(
                'Intentos realizados: $_intentos',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              if (_mensajeFeedback.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _haGanado ? Colors.green.shade100 : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _mensajeFeedback,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _haGanado ? Colors.green.shade900 : Colors.orange.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              if (_haGanado) ...[
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: _reiniciarJuego,
                  child: const Text('Jugar de nuevo'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}