import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/Model/M_Receta.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqflite.sqfliteFfiInit();

  final databasePath = await sqflite.getDatabasesPath();
  final database = await sqflite.openDatabase(
    path.join(databasePath, 'nombre_de_tu_base_de_datos.db'),
    version: 1,
    onCreate: (db, version) {
      // Aquí puedes crear la estructura de tu base de datos si es necesario
    },
  );

  final recetasViewModel = RecetasViewModel(
      MReceta(database)); // Crear una instancia de RecetasViewModel

  runApp(MyApp(
      database: database,
      recetasViewModel:
          recetasViewModel)); // Pasar la instancia de RecetasViewModel a MyApp
}

class MyApp extends StatelessWidget {
  final Database database;
  final RecetasViewModel recetasViewModel; // Agrega esta línea

  const MyApp(
      {Key? key, required this.database, required this.recetasViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecetasView(
          database: database,
          recetasViewModel:
              recetasViewModel), // Pasa la instancia de RecetasViewModel
    );
  }
}
