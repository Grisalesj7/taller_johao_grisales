import 'package:flutter/material.dart';
import 'screens/pantalla_clientes.dart';
import 'screens/pantalla_juego.dart';

void main() {
  runApp(const MiTallerApp());
}

class MiTallerApp extends StatelessWidget {
  const MiTallerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taller Formularios y Validaciones',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MenuPrincipalScreen(),
    );
  }
}

class MenuPrincipalScreen extends StatelessWidget {
  const MenuPrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Taller Flutter'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.fitness_center), text: 'Ejercicio 1'),
              Tab(icon: Icon(Icons.sports_esports), text: 'Ejercicio 2'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PantallaClientes(),
            PantallaJuego(),
          ],
        ),
      ),
    );
  }
}