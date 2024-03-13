import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recipeViewModel.dart';

class RecetaDetalladaWiew extends StatelessWidget {
  final RecipeViewModel recipeViewModel;
  final int recipeIndex;

  const RecetaDetalladaWiew(
      {Key? key, required this.recipeViewModel, required this.recipeIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtén la receta correspondiente al índice
    final Recipe recipe = recipeViewModel.recipes[recipeIndex];

    return Scaffold(
        appBar: AppBar(
          title: Text('Receta'),
          // Otras acciones del app bar
        ),
        body: Cuerpo());
  }
}

Widget Cuerpo() {
  return Center(
    child: Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RecetaDes(),
          SizedBox(height: 20),
          Text(
            'Ingredientes:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Ingredientes(),
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

Widget RecetaDes() {
  return Container(
    height: 200,
    width: 250,
    child: Image.network(
        "https://bing.com/th?id=OSK.19a39d79f953b931afef10230e77eaea"),
  );
}

Widget Ingredientes() {
  return Container(
    padding: EdgeInsets.all(12),
    color: Color.fromARGB(255, 158, 224, 96),
    child: Text(
      "Lista de ingredientes aquí",
      style: TextStyle(fontSize: 16),
    ),
  );
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

Widget nin() {
  return FloatingActionButton(
    onPressed: () {},
    child: null,
  );
}
