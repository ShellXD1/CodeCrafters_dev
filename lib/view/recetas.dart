import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';
<<<<<<< HEAD
import 'package:proyecto_tsp_dev/view/recetaDetallada.dart'; // Importa la clase RecetaDetalladaView
=======
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'recetaDetallada.dart'; // Importa la clase RecetaDetalladaView
>>>>>>> 2822faa4a3444ca0fc81e45b4a0a21026fd2f027

// Clase RecetasView
class RecetasView extends StatefulWidget {
  final RecetasViewModel recetasViewModel;
  final IngredienteViewModel ingredientesViewModel;
  final dynamic database;

  const RecetasView({Key? key, required this.recetasViewModel, required this.database, required this.ingredientesViewModel})
      : super(key: key);
<<<<<<< HEAD

  get ingredientesDisponibles => null;
=======
        get ingredientesDisponibles => null;
>>>>>>> 2822faa4a3444ca0fc81e45b4a0a21026fd2f027

  @override
  _RecetasViewState createState() => _RecetasViewState();
}

// Logica para mostrar las recetas
class _RecetasViewState extends State<RecetasView> {
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Mis Recetas',
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
                  future: widget.recetasViewModel!.getRecetasDisponibles(
                      widget.ingredientesDisponibles ?? []),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasData && snapshot.data != null) {
                        final List<Map<String, dynamic>> recetasDisponibles =
                            snapshot.data!;

                        if (recetasDisponibles.isEmpty) {
                          return Text(
                            'No se encontraron recetas disponibles.',
                            style: TextStyle(fontSize: 16),
                          );
                        }

                        return Column(
                          children: recetasDisponibles.map((recetaInfo) {
                            final String nombreReceta =
                                recetaInfo['nombre_receta'] ??
                                    'Receta sin nombre';
                            final String imagenRecetaPath =
                                recetaInfo['imagen_receta'] ?? '';
                            final int recipeIndex = recetaInfo['id_receta'] ??
                                0; // Corregido el índice de la receta

                            return RecetaItem(
                              recetaInfo: recetaInfo,
                              recetasViewModel: widget.recetasViewModel,
                              onFavoritoPressed: () {
                                setState(() {
                                  // Actualizar la lista de recetas para que el cambio de favoritos se refleje
                                  _actualizarRecetas();
                                });
                              },
                            );
                          }).toList(),
                        );
                      } else {
                        return Text(
                          'No se encontraron recetas disponibles.',
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
                    database: widget.database, ingredientesViewModel: widget.ingredientesViewModel, // Assuming you don't need database here
                  ),
                ),
<<<<<<< HEAD
                child: Text(
                  'Recetas',
                  style: TextStyle(
                      fontSize: 25.0, fontFamily: 'Chivo', color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/ingredientes');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9EE060),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
=======
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IngredientesView(
                    ingredientViewModel: widget.ingredientesViewModel,
                    database: widget.database, recetasViewModel: widget.recetasViewModel,
>>>>>>> 2822faa4a3444ca0fc81e45b4a0a21026fd2f027
                  ),
                ),
<<<<<<< HEAD
                child: Text(
                  'Ingredientes',
                  style: TextStyle(
                      fontSize: 25.0, fontFamily: 'Chivo', color: Colors.black),
                ),
              ),
            ),
          ],
        ),
=======
              );
              break;
          }
        },
>>>>>>> 2822faa4a3444ca0fc81e45b4a0a21026fd2f027
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

// Clase para mostrar la tarjeta de una receta
class RecetaItem extends StatefulWidget {
  final Map<String, dynamic> recetaInfo;
  final RecetasViewModel? recetasViewModel;
  final VoidCallback? onFavoritoPressed;

  const RecetaItem({
    Key? key,
    required this.recetaInfo,
    this.recetasViewModel,
    this.onFavoritoPressed,
  }) : super(key: key);

  @override
  _RecetaItemState createState() => _RecetaItemState();
}

// Clase para manejar el estado de la tarjeta de una receta
class _RecetaItemState extends State<RecetaItem> {
  late Future<bool> _futureEsFavorita;

  // Método para obtener el estado de favoritos
  @override
  void initState() {
    super.initState();
    // Obtener el estado de favoritos una vez inicializado el widget
    _futureEsFavorita = _obtenerEsFavorita();
  }

  // Método para obtener el estado de favoritos
  Future<bool> _obtenerEsFavorita() async {
    // Obtener el índice de la receta
    int recipeIndex = widget.recetaInfo['id_receta'] ?? 0;
    // Obtener el estado de favoritos desde el ViewModel
    return widget.recetasViewModel!.esRecetaFavorita(recipeIndex);
  }

  // Método para mostrar la tarjeta de una receta
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _futureEsFavorita,
      builder: (context, snapshot) {
        bool recetaEsFavorita = snapshot.data ?? false;
        final String nombreReceta =
            widget.recetaInfo['nombre_receta'] ?? 'Receta sin nombre';
        final String imagenRecetaPath =
            widget.recetaInfo['imagen_receta'] ?? '';
        final int recipeIndex = (widget.recetaInfo['id_receta']) - 1 ?? 0;
        // Mostrar la tarjeta de una receta
        return GestureDetector(
          onTap: () {
            // Navegar a la pantalla de detalles de la receta
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecetaDetalladaView(
                  recetasViewModel: widget.recetasViewModel!,
                  recipeIndex: recipeIndex,
                ),
              ),
            );
          },
          child: Container(
            width: 300,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imagenRecetaPath.isNotEmpty)
                      Image.asset(
                        '$imagenRecetaPath',
                        width: 200,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          nombreReceta,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BotonFavoritos(
                          esFavorita: recetaEsFavorita,
                          onPressed: () async {
                            // Cambiar el estado de favoritos cuando se presiona el botón
                            int recipeIndex =
                                widget.recetaInfo['id_receta'] ?? 0;
                            await widget.recetasViewModel!
                                .toggleFavorita(recipeIndex);
                            // Actualizar el estado de favoritos
                            setState(() {
                              _futureEsFavorita = _obtenerEsFavorita();
                            });
                            // Llamar a la función proporcionada, si existe
                            widget.onFavoritoPressed?.call();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Clase para mostrar el botón de favoritos
class BotonFavoritos extends StatelessWidget {
  final bool esFavorita;
  final VoidCallback onPressed;

  // Constructor
  const BotonFavoritos({
    Key? key,
    required this.esFavorita,
    required this.onPressed,
  }) : super(key: key);

  // Cuerpo del botón
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: esFavorita ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
      onPressed: onPressed,
    );
  }
}
