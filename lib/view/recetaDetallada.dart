import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recipeSingleViewModel.dart';

class RecetaDetalladaView extends StatelessWidget {
  final RecipeSingleViewModel recipeSingleViewModel;
  final int recipeIndex;

  const RecetaDetalladaView({
    Key? key,
    required this.recipeSingleViewModel,
    required this.recipeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtén la receta correspondiente al índice
    final RecipeSingle recipe =
        recipeSingleViewModel.recipeSingles[recipeIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Receta'),
        // Otras acciones del app bar
      ),
      body: Cuerpo(recipe: recipe),
    );
  }
}

Widget Cuerpo({required RecipeSingle recipe}) {
  return Center(
    child: Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RecetaDes(recipe),
          SizedBox(height: 20),
          Text(
            'Ingredientes:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          IngredientesWidget(),
          SizedBox(height: 20),
          Text(
            'Preparación:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          PreparacionWidget(),
        ],
      ),
    ),
  );
}

Widget RecetaDes(RecipeSingle recipe) {
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
                      Text("Lista de Ingredientes"),
                      SizedBox(height: 16),
                      Text("Aquí van los ingredientes de la receta"),
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
          "Lista de ingredientes aqui",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class PreparacionWidget extends StatelessWidget {
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
                      Text("Instrucciones de preparación"),
                      SizedBox(height: 16),
                      Text("Aquí van las instrucciones de preparación"),
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
          "Mostrar instrucciones de preparación",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
