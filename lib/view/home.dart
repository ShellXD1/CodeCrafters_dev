import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:sqflite_common/sqlite_api.dart';

class HomeScreen extends StatelessWidget {
  final RecetasViewModel recetasViewModel;
  final IngredienteViewModel ingredientViewModel;
  final Database database;

  const HomeScreen(
      {Key? key,
      required this.recetasViewModel,
      required this.ingredientViewModel,
      required this.database})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? _selectedIndex = null;
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
      //Desde este punto esta el navigationBar, no se logro implementar cierta persistencia, por lo cual es importante copiar este y pegarlo
      //en las vistas que se creen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 158, 224, 96),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recetas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Ingredientes',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecetasView(
                    recetasViewModel: recetasViewModel,
                    database: null, ingredientesViewModel: ingredientViewModel, // Assuming you don't need database here
                  ),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IngredientesView(
                    ingredientViewModel: ingredientViewModel,
                    database: database, recetasViewModel: recetasViewModel,
                  ),
                ),
              );
              break;
          }
        },
      ),
      
    );
  }
}
