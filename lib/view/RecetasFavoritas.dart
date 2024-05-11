import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/view/ingredientes.dart';
import 'package:proyecto_tsp_dev/view/recetaDetallada.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';

class RecetasFavoritasView extends StatefulWidget {
  final RecetasViewModel recetasViewModel;
  final IngredienteViewModel ingredienteViewModel;
  final dynamic database;

  const RecetasFavoritasView({Key? key, required this.recetasViewModel, required this.database, required this.ingredienteViewModel})
      : super(key: key);

  @override
  _RecetasViewState createState() => _RecetasViewState();
}

class _RecetasViewState extends State<RecetasFavoritasView> {
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
    if (!_recetasCargadas) {
      // Si las recetas no están cargadas, obtenerlas
      if (widget.recetasViewModel != null) {
        widget.recetasViewModel!.obtenerRecetas().then((_) {
          // Marcar como cargadas una vez que se hayan obtenido las recetas
          setState(() {
            _recetasCargadas = true;
          });
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas', style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo')),
        leading: IconButton(
          icon: Icon(Icons.home, size: 40.0),
          onPressed: () {
            print("Botón de la casita presionado (regresar a la pantalla de inicio)");
            Navigator.pushReplacementNamed(context, '/'); // Navegar directamente a la pantalla de inicio y reemplazar la ruta actual
          },
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.menu, size: 40.0), // Icono para el botón de menú
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
                // Navegar a la pantalla AllRecetasView usando la ruta previamente definida
                Navigator.pushNamed(context, '/allRecetas'); // Utiliza la ruta definida en MaterialApp
              } else if (value == 'ver_favoritas') {
                // Acción al seleccionar "Ver recetas favoritas"
                print("Ver recetas favoritas seleccionado");
                // Puedes agregar aquí la navegación o la lógica correspondiente
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
            // Mostrar las recetas una vez que estén cargadas
            if (_recetasCargadas && widget.recetasViewModel != null)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.recetasViewModel!.recetas.length,
                itemBuilder: (context, index) {
                  final receta = widget.recetasViewModel!.recetas[index];
                  
                  return GestureDetector(
                    onTap: () {
                      // Navegar a la pantalla de detalles de la receta seleccionada
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecetaDetalladaView(
                            recetasViewModel: widget.recetasViewModel,
                            recipeIndex: index, // Pasa el índice de la receta seleccionada
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Container(
                        width: 300, // Ancho deseado para la tarjeta
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FutureBuilder<Map<String, String?>>(
                                  future: widget.recetasViewModel!.obtenerImagenReceta(receta.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la imagen
                                    } else {
                                      if (snapshot.hasData && snapshot.data != null) {
                                        final rutaImagen = snapshot.data!['imagen'];
                                        return Image.asset(
                                          rutaImagen!,
                                          width: 200, // Ancho deseado de la imagen
                                          height: 100, // Alto deseado de la imagen
                                          fit: BoxFit.cover, // Ajuste de la imagen
                                        );
                                      } else {
                                        return Icon(Icons.error); // Manejar el error de carga de la imagen
                                      }
                                    }
                                  },
                                ),
                                SizedBox(height: 8),
                                Text(
                                  receta.nombre,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
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
                    database: widget.database, ingredientesViewModel: widget.ingredienteViewModel, // Assuming you don't need database here
                  ),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IngredientesView(
                    ingredientViewModel: widget.ingredienteViewModel,
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
}