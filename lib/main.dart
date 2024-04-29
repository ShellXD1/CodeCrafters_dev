import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:proyecto_tsp_dev/Model/M_Ingrediente.dart';
import 'package:proyecto_tsp_dev/Model/M_Receta.dart';
import 'package:proyecto_tsp_dev/view/home.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart'; // Importa la clase RecetasViewModel
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart'; // Importa la clase RecetasViewModel
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:proyecto_tsp_dev/view/AllRecetas.dart';
import 'package:proyecto_tsp_dev/view/RecetasFavoritas.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  // Obtener el directorio de documentos de la aplicación
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  final String databasePath = path.join(directory.path, 'Recetario.sqlite3');

  final prefs = await SharedPreferences.getInstance();
  bool isValidated = prefs.getBool('validation') ?? false;
  
  if (isValidated == false){
    // Copia el archivo desde los recursos a la ubicación local
    ByteData data = await rootBundle.load('assets/Recetario.sqlite3');
    List<int> bytes = data.buffer.asUint8List();
    await File(databasePath).writeAsBytes(bytes);
    prefs.setBool('validation', true);
  }


  // Abrir la base de datos
  final database = await sqflite.openDatabase(
    databasePath,
    version: 1,
  );

  WidgetsFlutterBinding.ensureInitialized();
  // Crear una instancia de MReceta con la base de datos
  print("Entre aqui we" + databasePath);
  final mReceta = MReceta(database);
  print("Entre aqui we, en receta");
  // Crear una instancia de MReceta con la base de datos
  final mIngrediente = MIngrediente(database);
  print("Entre aqui we, en ingrediente");
  // Crear una instancia de RecetasViewModel con MReceta
  final recetasViewModel = RecetasViewModel(mReceta);
  // Crear una instancia de IngredientViewModel con MReceta
  final ingredienteViewModel = IngredienteViewModel(mIngrediente);

  runApp(MyApp(
      database: database,
      recetasViewModel: recetasViewModel,
      ingredientViewModel: ingredienteViewModel));
} // El Shell se la come entera

class MyApp extends StatelessWidget {
  final Database database;
  final RecetasViewModel recetasViewModel;
  final IngredienteViewModel ingredientViewModel;

  const MyApp(
      {Key? key,
      required this.database,
      required this.recetasViewModel,
      required this.ingredientViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetario Inteligente',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(
          database: database,
          recetasViewModel: recetasViewModel,
          ingredientViewModel: ingredientViewModel),
      //RecetasView(database: database, recetasViewModel: recetasViewModel),
      routes: {
        '/ingredientes': (context) =>
            IngredientesView(ingredientViewModel: ingredientViewModel, database:database),
        '/recetas': (context) =>
            RecetasView(recetasViewModel: recetasViewModel, database: database,),
        '/allRecetas': (context) => AllRecetasView(recetasViewModel: recetasViewModel, database: database,),
        '/RecetasFavoritas': (context) => RecetasFavoritasView(recetasViewModel: recetasViewModel, database: database,),
      },
    );
  }
}
