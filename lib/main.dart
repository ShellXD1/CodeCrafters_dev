import 'package:flutter/material.dart';
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

void main() async {
  // Obtener el directorio de documentos de la aplicación
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  final String databasePath = path.join(directory.path, 'Recetario.sqlite3');

  // Abrir la base de datos
  final database = await sqflite.openDatabase(
    databasePath,
    version: 1,
  );

  WidgetsFlutterBinding.ensureInitialized();
  // Crear una instancia de MReceta con la base de datos
  final mReceta = MReceta(database);
  // Crear una instancia de MReceta con la base de datos
  final mIngrediente = MIngrediente(database);
  // Crear una instancia de RecetasViewModel con MReceta
  final recetasViewModel = RecetasViewModel(mReceta);
  // Crear una instancia de IngredientViewModel con MReceta
  final ingredienteViewModel = IngredienteViewModel(mIngrediente);

  runApp(MyApp(database: database, recetasViewModel: recetasViewModel, ingredientViewModel: ingredienteViewModel));
}

class MyApp extends StatelessWidget {
  final Database database;
  final RecetasViewModel recetasViewModel;
  final IngredienteViewModel ingredientViewModel;

  const MyApp(
      {Key? key, required this.database, required this.recetasViewModel, required this.ingredientViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetario Inteligente',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecetasView(database: database, recetasViewModel: recetasViewModel),
    );
  }
}
