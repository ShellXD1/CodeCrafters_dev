import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/home.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/recipeSingleViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';

void main() {
  final RecipeSingleViewModel recipeSingleViewModel = RecipeSingleViewModel();
  final IngredientViewModel ingredientViewModel = IngredientViewModel();

  runApp(MyApp(
    recipeSingleViewModel: recipeSingleViewModel,
    ingredientViewModel: ingredientViewModel,
  ));
}

class MyApp extends StatelessWidget {
  final RecipeSingleViewModel recipeSingleViewModel;
  final IngredientViewModel ingredientViewModel;

  const MyApp(
      {Key? key,
      required this.recipeSingleViewModel,
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
            recipeViewModel: recipeSingleViewModel,
            ingredientViewModel: ingredientViewModel),
        '/recetas': (context) =>
            RecetasView(recipeSingleViewModel: recipeSingleViewModel),
        '/ingredientes': (context) =>
            IngredientesView(ingredientViewModel: ingredientViewModel),
      },
    );
  }
}
