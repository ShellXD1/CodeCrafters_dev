import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';

class RecetasView extends StatefulWidget {
  final RecetasViewModel? recetasViewModel;
  final dynamic database;

  const RecetasView({Key? key, this.recetasViewModel, required this.database})
      : super(key: key);
      
        get ingredientesDisponibles => null;

  @override
  _RecetasViewState createState() => _RecetasViewState();
}

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
        SizedBox(height: 16), // Espaciado entre el texto y el indicador de carga

        // Mostrar un indicador de carga mientras se obtienen las recetas
        if (!_recetasCargadas)
          CircularProgressIndicator(),

        // Mostrar las recetas una vez que estén cargadas
        if (_recetasCargadas && widget.recetasViewModel != null)
          FutureBuilder<List<Map<String, dynamic>>>(
            future: widget.recetasViewModel!.getRecetasDisponibles(widget.ingredientesDisponibles ?? []),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData && snapshot.data != null) {
                  final List<Map<String, dynamic>> recetasDisponibles = snapshot.data!;

                  if (recetasDisponibles.isEmpty) {
                    return Text(
                      'No se encontraron recetas disponibles.',
                      style: TextStyle(fontSize: 16),
                    );
                  }

                  return Column(
                    children: recetasDisponibles.map((recetaInfo) {
                      final String nombreReceta = recetaInfo['nombre_receta'] ?? 'Receta sin nombre';
                      final String imagenRecetaPath = recetaInfo['imagen_receta'] ?? '';

                      return Container(
                        width: 300, // Ancho deseado para la tarjeta
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center, // Centra contenido verticalmente
                              children: [
                                if (imagenRecetaPath.isNotEmpty)
                                  Image.asset(
                                    imagenRecetaPath,
                                    width: 200, // Ancho de la imagen
                                    height: 100, // Alto de la imagen
                                    fit: BoxFit.cover,
                                  ),
                                SizedBox(height: 8), // Espaciado entre la imagen y el texto
                                Text(
                                  nombreReceta,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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

      bottomNavigationBar: Container(
        color: Color(0xFF9EE060),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón "Recetas"
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
}