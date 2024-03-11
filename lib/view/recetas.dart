import 'package:flutter/material.dart';

class RecetasView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas'),
      ),
      body: Center(
        child: Text(
          'Bienvenido a la pantalla de recetas',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}