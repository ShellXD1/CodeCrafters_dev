import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recipeSingleViewModel.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';

class HomeScreen extends StatelessWidget {
  final RecipeSingleViewModel recipeViewModel;
  final IngredientViewModel ingredientViewModel;

  const HomeScreen(
      {Key? key,
      required this.recipeViewModel,
      required this.ingredientViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        leading: IconButton(
          icon: Icon(Icons.home, size: 50.0),
          onPressed: () {
            print(
                "Botón de la casita presionado (regresar a la pantalla de inicio)");
          },
        ),
      ),
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
                  'Recetas del dia:',
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
                      for (var recipe in recipeViewModel.recipeSingles.take(3))
                        Text(
                          recipe.name,
                          style: TextStyle(fontSize: 25.0),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Ingredientes por terminarse:',
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
                      for (var recipe in ingredientViewModel.ingredient.take(3))
                        Text(
                          recipe.name,
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
      bottomNavigationBar: Container(
        color: Color(0xFF9EE060),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón "Recetas"
                  print("Botón 'Recetas' presionado");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecetasView(
                            recipeSingleViewModel: recipeViewModel)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9EE060),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  padding: EdgeInsets.all(16.0),
                ),
                child: Text(
                  'Recetas',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón "Ingredientes"
                  print("Botón 'Ingredientes' presionado");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IngredientesView(
                            ingredientViewModel: ingredientViewModel)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9EE060),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  padding: EdgeInsets.all(16.0),
                ),
                child: Text(
                  'Ingredientes',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
