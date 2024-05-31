import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';
import 'package:proyecto_tsp_dev/Model/recetadb.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:sqflite_common/sqlite_api.dart';

class HomeScreen extends StatefulWidget {
  final RecetasViewModel recetasViewModel;
  final IngredienteViewModel ingredientViewModel;
  final Database database;

  const HomeScreen({
    Key? key,
    required this.recetasViewModel,
    required this.ingredientViewModel,
    required this.database,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> _recetasAleatorias;
  late Future<List<Ingrediente>> _ingredientesMenosCantidad;

  @override
  void initState() {
    super.initState();
    // Llamar a los métodos para obtener recetas aleatorias e ingredientes con menor cantidad
    _recetasAleatorias = widget.recetasViewModel.getRecetasAleatorias([]);
    _ingredientesMenosCantidad = widget.ingredientViewModel.obtenerTresIngredientesMenosCantidad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio',
            style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo')),
        leading: IconButton(
          icon: Icon(Icons.home, size: 40.0),
          onPressed: () {
            print("Botón de la casita presionado (regresar a la pantalla de inicio)");
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Container(
              color: Color.fromARGB(255, 163, 253, 169),
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  '¡Bienvenido!',
                  style: TextStyle(fontSize: 36.0, fontFamily: 'Chivo', fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Recetas del dia:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontFamily: 'Chivo', fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _recetasAleatorias,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras se obtienen las recetas
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}')); // Muestra un mensaje de error si ocurre un error al obtener las recetas
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay recetas disponibles')); // Muestra un mensaje si no hay recetas disponibles
                } else {
                  // Muestra las recetas obtenidas
                  return Column(
                    children: snapshot.data!.map((receta) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: ListTile(
                          leading: Icon(Icons.restaurant_menu),
                          title: Text(receta['nombre_receta'], style: TextStyle(fontSize: 18.0)),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Ingredientes por terminarse:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontFamily: 'Chivo', fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            FutureBuilder<List<Ingrediente>>(
              future: _ingredientesMenosCantidad,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras se obtienen los ingredientes
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}')); // Muestra un mensaje de error si ocurre un error al obtener los ingredientes
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay ingredientes disponibles')); // Muestra un mensaje si no hay ingredientes disponibles
                } else {
                  // Muestra los ingredientes obtenidos
                  return Column(
                    children: snapshot.data!.map((ingrediente) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: ListTile(
                          leading: Icon(Icons.food_bank),
                          title: Text(ingrediente.nombre, style: TextStyle(fontSize: 18.0)),
                          subtitle: Text('Cantidad: ${ingrediente.cantidad}'),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 158, 224, 96),
        iconSize: 30.0,  // Aumenta el tamaño de los íconos
        selectedFontSize: 18.0,  // Aumenta el tamaño del texto seleccionado
        unselectedFontSize: 16.0,  // Aumenta el tamaño del texto no seleccionado
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
                    recetasViewModel: widget.recetasViewModel,
                    database: widget.database,
                    ingredientesViewModel: widget.ingredientViewModel,
                  ),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IngredientesView(
                    ingredientViewModel: widget.ingredientViewModel,
                    database: widget.database,
                    recetasViewModel: widget.recetasViewModel,
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
