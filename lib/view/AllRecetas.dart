import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/ComponentesView/tarjeta.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';
import 'package:proyecto_tsp_dev/view/recetaDetallada.dart'; // Importa la clase RecetaDetalladaView

// Clase RecetasFavoritasView
class AllRecetasView extends StatefulWidget {
  final RecetasViewModel? recetasViewModel;
  final dynamic database;
  final IngredienteViewModel? ingredientesViewModel;
  final IngredienteViewModel? ingredientViewModel;

  const AllRecetasView({
    Key? key,
    this.recetasViewModel,
    required this.database,
    this.ingredientesViewModel,
    this.ingredientViewModel,
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
      body: SingleChildScrollView(
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
      bottomNavigationBar: Container(
        color: Color(0xFF9EE060),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón "Recetas"
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/recetas');
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
                  ),
                  padding: EdgeInsets.all(16.0),
                ),
                child: Text(
                  'Ingredientes',
                  style: TextStyle(
                      fontSize: 25.0, fontFamily: 'Chivo', color: Colors.black),
                ),
              ),
            ),
          ],
        ),
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
