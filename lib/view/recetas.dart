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
        // Resto del AppBar omitido por brevedad...
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
            if (!_recetasCargadas)
              Center(child: CircularProgressIndicator()),
            if (_recetasCargadas && widget.recetasViewModel != null)
              FutureBuilder<List<Map<String, dynamic>>>(
                future: widget.recetasViewModel!
                    .getRecetasDisponibles(widget.ingredientesDisponibles ?? []),
                builder: (context, snapshot) {
                  // Resto del FutureBuilder omitido por brevedad...
                  return Column(
                    children: snapshot.data!.map<Widget>((recetaInfo) {
                      return GestureDetector(
                        onTap: () {
                          // Navegar a la pantalla de detalles de la receta
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecetaDetallesView(recetaInfo: recetaInfo),
                            ),
                          );
                        },
                        child: Container(
                          width: 300, // Ancho deseado para la tarjeta
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (recetaInfo['imagen'] != null)
                                    Image.asset(
                                      recetaInfo['imagen'],
                                      width: 200, // Ancho de la imagen
                                      height: 100, // Alto de la imagen
                                      fit: BoxFit.cover,
                                    ),
                                  SizedBox(height: 8), // Espaciado entre la imagen y el texto
                                  Text(
                                    recetaInfo['nombre_receta'] ?? 'Receta sin nombre',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            // Resto de la UI omitida por brevedad...
          ],
        ),
      ),
      // Resto del Scaffold omitido por brevedad...
    );
  }
}

class RecetaDetallesView extends StatelessWidget {
  final Map<String, dynamic> recetaInfo;

  const RecetaDetallesView({Key? key, required this.recetaInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Aquí puedes construir la pantalla de detalles de la receta usando la información de `recetaInfo`
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recetaInfo['nombre_receta'] ?? 'Detalles de la Receta',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (recetaInfo['imagen'] != null)
              Image.asset(
                recetaInfo['imagen'],
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            Text(
              'Descripción de la receta aquí...',
              style: TextStyle(fontSize: 18),
            ),
            // Agrega más información de la receta según necesites
          ],
        ),
      ),
    );
  }
}