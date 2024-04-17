import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart'; // Importa RecetasViewModel

class RecetasView extends StatefulWidget {
  final RecetasViewModel recetasViewModel; // Usa RecetasViewModel

  const RecetasView({Key? key, required this.recetasViewModel}) : super(key: key);

  @override
  _RecetasViewState createState() => _RecetasViewState();
}

class _RecetasViewState extends State<RecetasView> {
  @override
  void initState() {
    super.initState();
    // Cargar las recetas al iniciar la pantalla
    widget.recetasViewModel.obtenerRecetas();
  }

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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mostrar la lista de recetas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Mis Recetas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Usar ListView.builder para mostrar las recetas
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.recetasViewModel.recetas.length,
              itemBuilder: (context, index) {
                final receta = widget.recetasViewModel.recetas[index];
                return ListTile(
                  title: Text(receta.nombre),
                  // Puedes mostrar más detalles de la receta aquí
                );
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
                  // Acción al presionar el botón "Recetas"
                  print("Botón 'Recetas' presionado");
                  // Puedes agregar aquí una acción adicional al presionar el botón
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