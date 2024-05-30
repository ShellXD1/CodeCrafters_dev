import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';

class RecetaDetalladaView extends StatelessWidget {
  final RecetasViewModel recetasViewModel;
  final IngredienteViewModel ingredienteViewModel;
  final int recipeIndex;

  const RecetaDetalladaView({
    Key? key,
    required this.recetasViewModel,
    required this.recipeIndex, 
    required this.ingredienteViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de la receta',
          style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo'),
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([
          recetasViewModel.getRecipeDetails(recipeIndex),
          ingredienteViewModel.getIngredientesReceta(recipeIndex),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final recipeDetails = snapshot.data?[0];
            final ingredientes = snapshot.data?[1];
            return Cuerpo(
              recipeDetails: recipeDetails,
              ingredientes: ingredientes,
            );
          }
        },
      ),
    );
  }
}

class Cuerpo extends StatelessWidget {
  final Map<String, dynamic>? recipeDetails;
  final List<Map<String, dynamic>> ingredientes;

  const Cuerpo({Key? key, this.recipeDetails, required this.ingredientes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (recipeDetails == null || ingredientes == null) {
      return Center(
        child: Text('No se encontraron detalles de la receta o ingredientes'),
      );
    }

    final String preparacion = recipeDetails!['preparacion'];
    final String informacion = recipeDetails!['informacion'];

    return SingleChildScrollView(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          RecetaDes(recipeDetails!['imagen']),
          SizedBox(height: 20),
          Text(
            'Lista de Ingredientes:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Chivo',
            ),
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
              fontFamily: 'Chivo',
            ),
          ),
          SizedBox(height: 5),
          PreparacionWidget(preparacion: preparacion),
          SizedBox(height: 20),
          Text(
            'Lista de Información Nutricional:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Chivo',
            ),
          ),
          SizedBox(height: 5),
          InformacionWidget(informacion: informacion),
          SizedBox(height: 20),
        ],
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
    List<String> informacionList = preparacion.split('-');
    return ExpansionTile(
      title: Text(
        "Preparación",
        style: TextStyle(fontFamily: 'Chivo'),
      ),
      children: [
        for (var info in informacionList)
          ListTile(
            title: Text(
              info,
              textAlign: TextAlign.justify,
            ),
          ),
      ],
    );
  }
}

Widget RecetaDes(String imagen) {
  return Container(
    height: 200,
    width: 250,
    child: Image.asset(
      '$imagen',
      fit: BoxFit.cover,
      height: 150.0,
    ),
  );
}

class IngredientesWidget extends StatelessWidget {
  final List<Map<String, dynamic>> ingredientes;

  const IngredientesWidget({Key? key, required this.ingredientes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Ingredientes",
        style: TextStyle(fontFamily: 'Chivo'),
      ),
      children: [
        for (var ingrediente in ingredientes)
          ListTile(
            title: Text(
              ingrediente['cantidad_ingrediente'].toString() + ' ' + ingrediente['medida'] + ' de ' + ingrediente['nombre_ing'],  // Ajusta según la estructura de tus datos
              textAlign: TextAlign.justify,
            ),
          ),
      ],
    );
  }
}

class InformacionWidget extends StatelessWidget {
  final String informacion;

  const InformacionWidget({Key? key, required this.informacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> informacionList = informacion.split('-');
    return ExpansionTile(
      title: Text(
        "Información Nutricional",
        style: TextStyle(fontFamily: 'Chivo'),
      ),
      children: [
        for (var info in informacionList)
          ListTile(
            title: Text(
              info,
              textAlign: TextAlign.justify,
            ),
          ),
      ],
    );
  }
}
