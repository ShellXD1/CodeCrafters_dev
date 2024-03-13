import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/home.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/recipeViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';

void main() {
  final RecipeViewModel recipeViewModel = RecipeViewModel();
  final IngredientViewModel ingredientViewModel = IngredientViewModel();

  runApp(MyApp(
    recipeViewModel: recipeViewModel,
    ingredientViewModel: ingredientViewModel,
  ));
}

class MyApp extends StatelessWidget {
  final RecipeViewModel recipeViewModel;
  final IngredientViewModel ingredientViewModel;

  const MyApp(
      {Key? key,
      required this.recipeViewModel,
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
            recipeViewModel: recipeViewModel,
            ingredientViewModel: ingredientViewModel),
        '/recetas': (context) => RecetasView(recipeViewModel: recipeViewModel),
        '/ingredientes': (context) =>
            IngredientesView(ingredientViewModel: ingredientViewModel),
      },
    );
  }
}
