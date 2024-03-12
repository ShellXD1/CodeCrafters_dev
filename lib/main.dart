import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/home.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/recipeViewModel.dart';

void main() {
  final RecipeViewModel recipeViewModel = RecipeViewModel();

  runApp(MyApp(recipeViewModel: recipeViewModel));
}

class MyApp extends StatelessWidget {
  final RecipeViewModel recipeViewModel;

  const MyApp({Key? key, required this.recipeViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(recipeViewModel: recipeViewModel),
        '/recetas': (context) => RecetasView(recipeViewModel: recipeViewModel),
      },
    );
  }
}