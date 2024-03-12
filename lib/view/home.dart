import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/recipeViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:proyecto_tsp_dev/view/baseScreen.dart';

class HomeScreen extends StatelessWidget {
  final RecipeViewModel recipeViewModel;
  final IngredientViewModel ingredientViewModel;

  const HomeScreen({Key? key, required this.recipeViewModel, required this.ingredientViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      recipeViewModel: recipeViewModel,
      ingredientViewModel: ingredientViewModel,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                '¡Bienvenido!',
                style: TextStyle(fontSize: 36.0),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Recetas:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(30.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      for (var recipe in recipeViewModel.recipes)
                        Text(
                          recipe.name,
                          style: TextStyle(fontSize: 25.0),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Ingredientes de Cocina:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(30.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Ingrediente 1',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Text(
                        'Ingrediente 2',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Text(
                        'Ingrediente 3',
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}