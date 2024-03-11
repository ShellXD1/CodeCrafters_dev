import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Text(
          'Bienvenido a la pantalla de inicio',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}