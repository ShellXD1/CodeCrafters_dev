import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/recipeViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:proyecto_tsp_dev/view/baseScreen.dart';


class IngredientesView extends StatelessWidget {
  final IngredientViewModel ingredientViewModel;

  const IngredientesView({Key? key, required this.ingredientViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      recipeViewModel: RecipeViewModel(), // Debes pasar el ViewModel necesario, aunque no lo uses en esta vista
      ingredientViewModel: ingredientViewModel,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Ingredientes:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      for (var ingredient in ingredientViewModel.ingredient)
                        IngredientCard(
                          quantity: ingredient.quantity,
                          name: ingredient.name,
                          onTap: () {
                            print("Ingrediente '${ingredient.name}' seleccionado");
                            // Puedes navegar a una nueva pantalla para ver los detalles del ingrediente aquí
                          },
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

class IngredientCard extends StatelessWidget {
  final int quantity;
  final String name;
  final VoidCallback onTap;

  const IngredientCard({
    Key? key,
    required this.quantity,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Quantity: $quantity',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

