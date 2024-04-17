import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recipeViewModel.dart';

class RecetaDetalladaView extends StatelessWidget {
  final RecipeViewModel recipeViewModel;
  final int recipeIndex;

  const RecetaDetalladaView({
    Key? key,
    required this.recipeViewModel,
    required this.recipeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtén la receta correspondiente al índice
    final Recipe recipe = recipeViewModel.recipes[recipeIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la receta',
            style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo')),
        // Otras acciones del app bar
      ),
      body: Cuerpo(recipe: recipe),
    );
  }
}

Widget Cuerpo({required Recipe recipe}) {
  return Center(
    child: Container(
        padding: EdgeInsets.all(12),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RecetaDes(recipe),
              SizedBox(height: 20),
              Text(
                'Lista de Ingredientes:',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Chivo'),
              ),
              SizedBox(height: 5),
              IngredientesWidget(ingredient: recipe.ingredient),
              SizedBox(height: 20),
              Text(
                'Lista de Preparación:',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Chivo'),
              ),
              SizedBox(height: 5),
              PreparacionWidget(process: recipe.process),
            ],
          ),
        )),
  );
}

Widget RecetaDes(Recipe recipe) {
  return Container(
    height: 200,
    width: 250,
    child: Image.asset(
      'assets/recetas/${recipe.image}',
      fit: BoxFit.cover,
      height: 150.0,
    ),
  );
}

class IngredientesWidget extends StatelessWidget {
  final String ingredient;

  const IngredientesWidget({Key? key, required this.ingredient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color.fromARGB(255, 158, 224, 96),
              content: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Ingredientes",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Chivo')),
                      SizedBox(height: 16),
                      Text(ingredient),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        color: Color.fromARGB(255, 158, 224, 96),
        child: Text(
          "Ingredientes",
          style: TextStyle(fontSize: 16, fontFamily: 'Chivo'),
        ),
      ),
    );
  }
}

class PreparacionWidget extends StatelessWidget {
  final String process;

  const PreparacionWidget({Key? key, required this.process}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color.fromARGB(255, 158, 224, 96),
              content: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Preparación",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Chivo')),
                      SizedBox(height: 16),
                      Text(process),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        color: Color.fromARGB(255, 158, 224, 96),
        child: Text(
          "Preparación",
          style: TextStyle(fontSize: 16, fontFamily: 'Chivo'),
        ),
      ),
    );
  }
}
