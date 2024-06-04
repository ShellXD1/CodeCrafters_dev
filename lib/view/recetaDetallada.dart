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
          recetasViewModel.obtenerInfoNutriReceta(
              recipeIndex), // Llamada adicional para la información nutricional
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
          } else if (snapshot.hasData) {
            final recipeDetails = snapshot.data?[0] as Map<String, dynamic>?;
            final ingredientes =
                snapshot.data?[1] as List<Map<String, dynamic>>?;
            final infoNutricional = snapshot.data?[2] as Map<String,
                String?>?; // Nueva variable para la información nutricional

            if (recipeDetails == null ||
                ingredientes == null ||
                infoNutricional == null) {
              return Center(
                child: Text(
                    'No se encontraron detalles de la receta, ingredientes o información nutricional'),
              );
            }

            return Cuerpo(
              recipeDetails: recipeDetails,
              ingredientes: ingredientes,
              infoNutricional:
                  infoNutricional, // Pasar la información nutricional
            );
          } else {
            return Center(
              child: Text('No se encontraron datos.'),
            );
          }
        },
      ),
    );
  }
}

class Cuerpo extends StatelessWidget {
  final Map<String, dynamic> recipeDetails;
  final List<Map<String, dynamic>> ingredientes;
  final Map<String, String?>
      infoNutricional; // Nueva variable para la información nutricional

  const Cuerpo(
      {Key? key,
      required this.recipeDetails,
      required this.ingredientes,
      required this.infoNutricional})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String preparacion = recipeDetails['preparacion'];
    final String informacion = recipeDetails['informacion'];
    final String? infoNutri = infoNutricional[
        'info_nutricional']; // Obtener la información nutricional

    return SingleChildScrollView(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            recipeDetails['nombre'].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Chivo',
            ),
          ),
          SizedBox(height: 20),
          RecetaDes(imagen: recipeDetails['imagen']),
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
            'Información Nutricional:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Chivo',
            ),
          ),
          SizedBox(height: 5),
          InformacionWidget(
              informacion: infoNutri ??
                  'No disponible'), // Pasar la información nutricional
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
    List<String> preparacionList = preparacion.split('-');
    return ExpansionTile(
      title: Text(
        "Preparación",
        style: TextStyle(fontFamily: 'Chivo'),
      ),
      children: preparacionList
          .map((step) => ListTile(
                title: Text(
                  step,
                  textAlign: TextAlign.justify,
                ),
              ))
          .toList(),
    );
  }
}

class RecetaDes extends StatelessWidget {
  final String imagen;

  const RecetaDes({Key? key, required this.imagen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 250,
      child: Image.asset(
        imagen,
        fit: BoxFit.cover,
      ),
    );
  }
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
      children: ingredientes
          .map((ingrediente) => ListTile(
                title: Text(
                  '${ingrediente['cantidad_ingrediente']} ${ingrediente['medida']} de ${ingrediente['nombre_ing']}',
                  textAlign: TextAlign.justify,
                ),
              ))
          .toList(),
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
      children: informacionList
          .map((info) => ListTile(
                title: Text(
                  info,
                  textAlign: TextAlign.justify,
                ),
              ))
          .toList(),
    );
  }
}
