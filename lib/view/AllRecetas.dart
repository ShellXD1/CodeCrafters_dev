import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';

class AllRecetasView extends StatefulWidget {
  final RecetasViewModel? recetasViewModel;
  final dynamic database;

  const AllRecetasView({Key? key, this.recetasViewModel, required this.database})
      : super(key: key);

  @override
  _RecetasViewState createState() => _RecetasViewState();
}

class _RecetasViewState extends State<AllRecetasView> {
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
            Navigator.pop(context); // Regresar a la pantalla de inicio
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
                print("Ver todas las seleccionado");
              } else if (value == 'ver_favoritas') {
                // Acción al seleccionar "Ver recetas favoritas"
                Navigator.pushNamed(context, '/RecetasFavoritas');
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
                  return Center(
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
      bottomNavigationBar: Container(
        color: Color(0xFF9EE060),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                      // Acción al presionar el botón "Recetas"
                      print("Botón 'Recetas' presionado");
                      Navigator.popUntil(
                          context,
                          ModalRoute.withName(
                              '/')); // Regresar a la pantalla de inicio
                      Navigator.pushNamed(context,'/recetas'); // Navegar a la pantalla de recetas
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
                  // Acción al presionar el botón "Ingredientes"
                  print("Botón 'Ingredientes' presionado");
                  Navigator.popUntil(context, ModalRoute.withName('/')); // Regresar a la pantalla de inicio
                  Navigator.pushNamed(context, '/ingredientes'); // Navegar a la pantalla de ingredientes
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