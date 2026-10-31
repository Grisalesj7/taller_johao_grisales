import 'package:flutter/material.dart';

class PantallaClientes extends StatefulWidget {
  const PantallaClientes({super.key});

  @override
  State<PantallaClientes> createState() => _PantallaClientesState();
}

class _PantallaClientesState extends State<PantallaClientes> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _edadCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _telefonoCtrl = TextEditingController();
  final TextEditingController _diasCtrl = TextEditingController();

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _edadCtrl.dispose();
    _emailCtrl.dispose();
    _telefonoCtrl.dispose();
    _diasCtrl.dispose();
    super.dispose();
  }

  void _registrarCliente() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El registro se realizó correctamente'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Registro de Cliente - Gimnasio',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              // 1. Nombre completo
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  if (val.trim().length < 3) {
                    return 'Debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // 2. Edad
              TextFormField(
                controller: _edadCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'La edad es obligatoria';
                  }
                  final edad = int.tryParse(val.trim());
                  if (edad == null) {
                    return 'Ingrese un número entero válido';
                  }
                  if (edad < 18) {
                    return 'Debe ser mayor o igual a 18 años';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // 3. Correo electrónico
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'El correo es obligatorio';
                  }
                  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegExp.hasMatch(val.trim())) {
                    return 'Ingrese un correo electrónico válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // 4. Número de teléfono
              TextFormField(
                controller: _telefonoCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Número de teléfono',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'El teléfono es obligatorio';
                  }
                  final phoneRegExp = RegExp(r'^\d{10}$');
                  if (!phoneRegExp.hasMatch(val.trim())) {
                    return 'Debe contener exactamente 10 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // 5. Días de asistencia por semana
              TextFormField(
                controller: _diasCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Días de asistencia por semana (1 a 7)',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Los días de asistencia son obligatorios';
                  }
                  final dias = int.tryParse(val.trim());
                  if (dias == null) {
                    return 'Ingrese un número entero';
                  }
                  if (dias < 1 || dias > 7) {
                    return 'El valor debe estar entre 1 y 7';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Botón Registrar
              ElevatedButton(
                onPressed: _registrarCliente,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Registrar cliente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}