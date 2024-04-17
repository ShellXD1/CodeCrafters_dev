import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:proyecto_tsp_dev/Model/M_Ingrediente.dart';
import 'package:proyecto_tsp_dev/Model/M_Receta.dart';
import 'package:proyecto_tsp_dev/view/home.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';

void main() async {
  final database = await openDatabase('proyecto_tsp_dev/Model/Recetario.sqlite3');
  final _mIngredientes = MIngrediente(database);
  final _mRecetas = MReceta(database);
  final recetasViewModel = RecetasViewModel(_mRecetas);
  final ingredienteViewModel = IngredienteViewModel(_mIngredientes);

  // Ejecuta la aplicación
  runApp(MyApp(
    recetasViewModel: recetasViewModel,
    ingredientViewModel: ingredienteViewModel,
  ));
}
  /*
  final MIngrediente _mIngredientes = new MIngrediente();

  final RecipeViewModel recipeViewModel = RecipeViewModel();
  final IngredienteViewModel ingredientViewModel = IngredienteViewModel(_mIngredientes);

  runApp(MyApp(
    recipeViewModel: recipeViewModel,
    ingredientViewModel: ingredientViewModel,
  ));
  */

class MyApp extends StatelessWidget {
  final RecetasViewModel recetasViewModel;
  final IngredienteViewModel ingredientViewModel;

  const MyApp(
      {Key? key,
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
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(
            recetasViewModel: recetasViewModel,
            ingredientViewModel: ingredientViewModel),
        '/recetas': (context) => RecetasView(recetasViewModel: recetasViewModel),
        '/ingredientes': (context) =>
            IngredientesView(ingredientViewModel: ingredientViewModel),
      },
    );
  }
}
