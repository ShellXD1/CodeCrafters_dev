import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/ComponentesView/tarjeta.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';
import 'package:proyecto_tsp_dev/view/recetaDetallada.dart'; // Importa la clase RecetaDetalladaView

// Clase RecetasFavoritasView
class AllRecetasView extends StatefulWidget {
  final RecetasViewModel recetasViewModel;
  final dynamic database;
  final IngredienteViewModel ingredientesViewModel;

  const AllRecetasView({
    Key? key,
    required this.recetasViewModel,
    required this.database,
    required this.ingredientesViewModel,
  }) : super(key: key);

  @override
  _RecetasViewState createState() => _RecetasViewState();
}

// Logica para mostrar las recetas
class _RecetasViewState extends State<AllRecetasView> {
  bool _recetasCargadas = false;

  @override
  void initState() {
    super.initState();
    if (widget.recetasViewModel != null) {
      widget.recetasViewModel!.obtenerRecetas().then((_) {
        setState(() {
          _recetasCargadas = true;
        });
      });
    }
  }

  // Carga las recetas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recetas',
          style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo'),
        ),
        leading: IconButton(
          icon: Icon(Icons.home, size: 40.0),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.menu, size: 40.0),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  'Ver todas las recetas',
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Chivo'),
                ),
                value: 'ver_todas',
              ),
              PopupMenuItem(
                child: Text(
                  'Ver recetas favoritas',
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Chivo'),
                ),
                value: 'ver_favoritas',
              ),
            ],
            onSelected: (value) {
              if (value == 'ver_todas') {
                Navigator.pushNamed(context, '/allRecetas');
              } else if (value == 'ver_favoritas') {
                Navigator.pushNamed(context, '/RecetasFavoritas');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterChip(
                  label: Text('Desayunos'),
                  backgroundColor: Color(0xFF9EE060),
                  onSelected: (bool selected) {
                    // Lógica para filtrar recetas de desayunos
                  },
                ),
                FilterChip(
                  label: Text('Comidas'),
                  backgroundColor: Color(0xFF9EE060),
                  onSelected: (bool selected) {
                    // Lógica para filtrar recetas de comidas
                  },
                ),
                FilterChip(
                  label: Text('Cenas'),
                  backgroundColor: Color(0xFF9EE060),
                  onSelected: (bool selected) {
                    // Lógica para filtrar recetas de cenas
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Lista de Recetas',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height:
                            16), // Espaciado entre el texto y el indicador de carga

                    // Mostrar un indicador de carga mientras se obtienen las recetas
                    if (!_recetasCargadas) CircularProgressIndicator(),

                    // Mostrar las recetas una vez que estén cargadas
                    if (_recetasCargadas && widget.recetasViewModel != null)
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: widget.recetasViewModel!.getRecetas(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            if (snapshot.hasData && snapshot.data != null) {
                              final List<Map<String, dynamic>> recetasFavoritas =
                                  snapshot.data!;

                              if (recetasFavoritas.isEmpty) {
                                return Text(
                                  'No se encontraron recetas.',
                                  style: TextStyle(fontSize: 16),
                                );
                              }

                              return Column(
                                children: recetasFavoritas.map((recetaInfo) {
                                  final String nombreReceta =
                                      recetaInfo['nombre_receta'] ??
                                          'Receta sin nombre';
                                  final String imagenRecetaPath =
                                      recetaInfo['imagen_receta'] ?? '';
                                  final int recipeIndex =
                                      recetaInfo['id_receta'] ?? 0;

                                  return RecetaItem(
                                    recetaInfo: recetaInfo,
                                    recetasViewModel: widget.recetasViewModel,
                                    onFavoritoPressed: () {
                                      setState(() {
                                        _actualizarRecetas();
                                      });
                                    },
                                  );
                                }).toList(),
                              );
                            } else {
                              return Text(
                                'No se encontraron recetas.',
                                style: TextStyle(fontSize: 16),
                              );
                            }
                          }
                        },
                      ),

                    // Mostrar un mensaje si no se proporcionó un RecetasViewModel
                    if (_recetasCargadas && widget.recetasViewModel == null)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'No se ha proporcionado un ViewModel de recetas.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                  ],
                ),
              ),
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
                    recetasViewModel: widget.recetasViewModel,
                    database: null, ingredientesViewModel: widget.ingredientesViewModel, // Assuming you don't need database here
                  ),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IngredientesView(
                    ingredientViewModel: widget.ingredientesViewModel,
                    database: widget.database, recetasViewModel: widget.recetasViewModel,
                  ),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  // Método para actualizar las recetas
  void _actualizarRecetas() {
    setState(() {
      _recetasCargadas = false;
    });
    widget.recetasViewModel!.obtenerRecetas().then((_) {
      setState(() {
        _recetasCargadas = true;
      });
    });
  }
}
