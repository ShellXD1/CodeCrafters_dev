import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recipeViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:proyecto_tsp_dev/view/baseScreen.dart';

class RecetasView extends StatelessWidget {
  final RecipeViewModel recipeViewModel;

  const RecetasView({Key? key, required this.recipeViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      recipeViewModel: recipeViewModel,
      ingredientViewModel: IngredientViewModel(), // Debes pasar el ViewModel necesario, aunque no lo uses en esta vista
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            Column(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final VoidCallback onTap;

  const RecipeCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blueGrey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 150.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

