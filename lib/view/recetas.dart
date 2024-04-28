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
  @override
  void initState() {
    super.initState();
    // Verificar si se proporcionó un RecetasViewModel antes de cargar las recetas
    if (widget.recetasViewModel != null) {
      widget.recetasViewModel!.obtenerRecetas();
    }
  }

  bool _recetasCargadas = false;

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas', style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo')),
        leading: IconButton(
          icon: Icon(Icons.home, size: 40.0),
          onPressed: () {
            print("Botón de la casita presionado (regresar a la pantalla de inicio)");
            Navigator.pop(context); // Regresar a la pantalla de inicio
          },
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.menu, size: 40.0),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Ver todas las recetas', style: TextStyle(fontSize: 20.0, fontFamily: 'Chivo')),
                value: 'ver_todas',
              ),
              PopupMenuItem(
                child: Text('Ver recetas favoritas', style: TextStyle(fontSize: 20.0, fontFamily: 'Chivo')),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Mis Recetas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Mostrar un indicador de carga mientras se obtienen las recetas
            if (!_recetasCargadas)
              Center(child: CircularProgressIndicator()),
            // Mostrar las recetas una vez que estén cargadas y filtradas por ingredientes disponibles
            if (_recetasCargadas && widget.recetasViewModel != null)
              FutureBuilder<List<Map<String, dynamic>>>(
                future: widget.recetasViewModel?.getRecetasDisponibles([]), // Pasar la lista de ingredientes disponibles
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final recetaInfo = snapshot.data![index];
                          final recetaId = recetaInfo['id']; // Obtener el ID de la receta

                          return FutureBuilder<Map<String, String?>>(
                            future: widget.recetasViewModel?.obtenerImagenReceta(recetaId),
                            builder: (context, imagenSnapshot) {
                              if (imagenSnapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else {
                                final rutaImagen = imagenSnapshot.data!['imagen'];
                                final nombreReceta = recetaInfo['nombre'] ?? 'Receta sin nombre';

                                return Container(
                                  width: 200,
                                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                  child: Card(
                                    elevation: 4.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Image.asset(
                                          rutaImagen!,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            nombreReceta,
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No hay recetas disponibles.'));
                    }
                  }
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF9EE060),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  print("Botón 'Recetas' presionado");
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
                  style: TextStyle(fontSize: 25.0, fontFamily: 'Chivo', color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  print("Botón 'Ingredientes' presionado");
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
                  style: TextStyle(fontSize: 25.0, fontFamily: 'Chivo', color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}