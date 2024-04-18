import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';

class HomeScreen extends StatelessWidget {
  final RecetasViewModel recetasViewModel;
  final IngredienteViewModel ingredientViewModel;

  const HomeScreen(
      {Key? key,
      required this.recetasViewModel,
      required this.ingredientViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio',
            style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo')),
        leading: IconButton(
          icon: Icon(Icons.home, size: 40.0),
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
                style: TextStyle(fontSize: 36.0, fontFamily: 'Chivo'),
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
                  style: TextStyle(fontSize: 24.0, fontFamily: 'Chivo'),
                ),
                Text(
                  'Ingredientes por terminarse:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontFamily: 'Chivo'),
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
                        builder: (context) =>
                            RecetasView(recetasViewModel: recetasViewModel)),
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
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Chivo',
                    color: Colors.black,
                  ),
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
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Chivo',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
