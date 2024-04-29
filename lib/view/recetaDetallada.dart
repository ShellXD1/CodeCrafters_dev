import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';

class RecetaDetalladaView extends StatelessWidget {
  final RecetasViewModel recetasViewModel;
  final int recipeIndex;

  const RecetaDetalladaView({
    Key? key,
    required this.recetasViewModel,
    required this.recipeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la receta',
            style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo')),
        // Otras acciones del app bar
      ),
      body: FutureBuilder(
        future: recetasViewModel.getRecipeDetails(recipeIndex),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Cuerpo(recipeDetails: snapshot.data);
          }
        },
      ),
    );
  }
}

class Cuerpo extends StatelessWidget {
  final Map<String, dynamic>? recipeDetails;

  const Cuerpo({Key? key, this.recipeDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (recipeDetails == null) {
      return Center(
        child: Text('No se encontraron detalles de la receta'),
      );
    }

    final List<String> ingredientes = recipeDetails!['ingredientes'];
    final String preparacion = recipeDetails!['preparacion'];

    return Center(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RecetaDes(recipeDetails!['imagen']),
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
              IngredientesWidget(ingredientes: ingredientes),
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
              PreparacionWidget(preparacion: preparacion),
            ],
          ),
        ),
      ),
    );
  }
}

Widget RecetaDes(String imagen) {
  return Container(
    height: 200,
    width: 250,
    child: Image.asset(
      'assets/recetas/$imagen',
      fit: BoxFit.cover,
      height: 150.0,
    ),
  );
}

class IngredientesWidget extends StatelessWidget {
  final List<String> ingredientes;

  const IngredientesWidget({Key? key, required this.ingredientes})
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
                      Text(ingredientes.join('\n')),
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
  final String preparacion;

  const PreparacionWidget({Key? key, required this.preparacion})
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
                      Text("Preparación",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Chivo')),
                      SizedBox(height: 16),
                      Text(preparacion),
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
