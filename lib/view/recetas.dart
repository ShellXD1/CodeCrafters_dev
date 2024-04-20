import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart'; // Importa RecetasViewModel

class RecetasView extends StatefulWidget {
  final RecetasViewModel?
      recetasViewModel; // RecetasViewModel ahora es opcional
  final dynamic
      database; // Asegúrate de utilizar este database donde sea necesario

  const RecetasView({Key? key, this.recetasViewModel, required this.database})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas',
            style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo')),
        leading: IconButton(
          icon: Icon(Icons.home, size: 40.0),
          onPressed: () {
            print(
                "Botón de la casita presionado (regresar a la pantalla de inicio)");
            Navigator.pop(context); // Regresar a la pantalla de inicio
          },
        ),
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
            // Mostrar las recetas solo si se proporcionó un RecetasViewModel
            if (widget.recetasViewModel != null)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.recetasViewModel!.recetas.length,
                itemBuilder: (context, index) {
                  final receta = widget.recetasViewModel!.recetas[index];
                  return ListTile(
                    title: Text(receta.nombre),
                    // Puedes mostrar más detalles de la receta aquí
                  );
                },
              ),
            // Mostrar un mensaje si no se proporcionó un RecetasViewModel
            if (widget.recetasViewModel == null)
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
                  style: TextStyle(
                      fontSize: 25.0, fontFamily: 'Chivo', color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón "Ingredientes"
                  print("Botón 'Ingredientes' presionado");
                  Navigator.popUntil(
                      context,
                      ModalRoute.withName(
                          '/')); // Regresar a la pantalla de inicio
                  Navigator.pushNamed(context,
                      '/ingredientes'); // Navegar a la pantalla de ingredientes
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
