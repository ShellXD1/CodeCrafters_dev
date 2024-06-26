import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/ComponentesView/tarjeta.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';
import 'package:proyecto_tsp_dev/view/recetaDetallada.dart'; // Importa la clase RecetaDetalladaView

// Clase RecetasFavoritasView
class RecetasFavoritasView extends StatefulWidget {
  final RecetasViewModel recetasViewModel;
  final dynamic database;
  final IngredienteViewModel ingredientesViewModel;

  const RecetasFavoritasView({
    Key? key,
    required this.recetasViewModel,
    required this.database,
    required this.ingredientesViewModel,
  }) : super(key: key);

  @override
  _RecetasFavoritasViewState createState() => _RecetasFavoritasViewState();
}

// Logica para mostrar las recetas
class _RecetasFavoritasViewState extends State<RecetasFavoritasView> {
  bool _recetasCargadas = false;
  String _filtroActual = '';

  @override
  void initState() {
    super.initState();
    _actualizarRecetas();
  }

  // Método para actualizar las recetas según el filtro
  void _actualizarRecetas() {
    setState(() {
      _recetasCargadas = false;
    });

    Future<List<Map<String, dynamic>>> futureRecetas;

    switch (_filtroActual) {
      case 'Desayunos':
        futureRecetas = widget.recetasViewModel.obtenerRecetasFavoritasDesayuno();
        break;
      case 'Comidas':
        futureRecetas = widget.recetasViewModel.obtenerRecetasFavoritasComida();
        break;
      case 'Cenas':
        futureRecetas = widget.recetasViewModel.obtenerRecetasFavoritasCena();
        break;
      default:
        futureRecetas = widget.recetasViewModel.getRecetasFavoritas();
        break;
    }

    futureRecetas.then((_) {
      setState(() {
        _recetasCargadas = true;
      });
    });
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
                  'Ver recetas recomendadas',
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Chivo'),
                ),
                value: 'ver_recomendadas',
              ),
            ],
            onSelected: (value) {
              if (value == 'ver_todas') {
                Navigator.pushNamed(context, '/allRecetas');
              } else if (value == 'ver_recomendadas') {
                Navigator.pushNamed(context, '/recetas');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterChip('Desayunos', 'desayunos'),
                _buildFilterChip('Comidas', 'comidas'),
                _buildFilterChip('Cenas', 'cenas'),
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
                      'Recetas favoritas',
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
                        future: _obtenerRecetasFiltradas(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            if (snapshot.hasData && snapshot.data != null) {
                              final List<Map<String, dynamic>> recetasFavoritas =
                                  snapshot.data!;

                              if (recetasFavoritas.isEmpty) {
                                return Text(
                                  'No se encontraron recetas favoritas.',
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
                                    }, ingredientesViewModel: widget.ingredientesViewModel,
                                  );
                                }).toList(),
                              );
                            } else {
                              return Text(
                                'No se encontraron recetas favoritas.',
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
                    database: null, 
                    ingredientesViewModel: widget.ingredientesViewModel, // Assuming you don't need database here
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

    // Método para obtener las recetas filtradas
  Future<List<Map<String, dynamic>>> _obtenerRecetasFiltradas() async {
    if (widget.recetasViewModel != null) {
      if (_filtroActual == 'desayunos') {
        return await widget.recetasViewModel.obtenerRecetasFavoritasDesayuno();
      } else if (_filtroActual == 'comidas') {
        return await widget.recetasViewModel.obtenerRecetasFavoritasComida();
      } else if (_filtroActual == 'cenas') {
        return await widget.recetasViewModel.obtenerRecetasFavoritasCena();
      } else {
        return await widget.recetasViewModel.getRecetasFavoritas();
      }
    } else {
      return [];
    }
  }

  // Método para cargar las recetas filtradas
  void _cargarRecetasFiltradas() {
    setState(() {
      _recetasCargadas = false;
    });
    _obtenerRecetasFiltradas().then((_) {
      setState(() {
        _recetasCargadas = true;
      });
    });
  }






  // Método para construir un FilterChip con estilos personalizados
  Widget _buildFilterChip(String label, String filtro) {
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: _filtroActual == filtro ? Colors.white : Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      selectedColor: Color(0xFF9EE060),
      shape: StadiumBorder(
        side: BorderSide(color: Color(0xFF9EE060)),
      ),
      elevation: 4.0,
      shadowColor: Colors.black.withOpacity(0.5),
      selected: _filtroActual == filtro,
      onSelected: (bool selected) {
        setState(() {
          _filtroActual = selected ? filtro : 'todas';
          _cargarRecetasFiltradas();
        });
      },
    );
  }

}