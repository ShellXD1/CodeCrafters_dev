import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pantalla de Inicio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            // Acción al presionar el botón de la casita (regresar a la pantalla de inicio)
            print("Botón de la casita presionado (regresar a la pantalla de inicio)");
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: const Color.fromARGB(255, 255, 255, 255), // Puedes cambiar el color de fondo si lo deseas
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                '¡Bienvenido!',
                style: TextStyle(fontSize: 36.0),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Recetas:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Receta 1',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        'Receta 2',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        'Receta 3',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Ingredientes de Cocina:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Ingrediente 1',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        'Ingrediente 2',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        'Ingrediente 3',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF9EE060), // Color personalizado
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón "Recetas"
                  print("Botón 'Recetas' presionado");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9EE060), // Color personalizado
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Hace que el botón sea rectangular
                  ),
                  padding: EdgeInsets.all(16.0), // Aumenta el padding del botón para hacerlo más grande
                ),
                child: Text(
                  'Recetas',
                  style: TextStyle(fontSize: 20.0), // Aumenta el tamaño del texto
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón "Ingredientes"
                  print("Botón 'Ingredientes' presionado");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9EE060), // Color personalizado
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Hace que el botón sea rectangular
                  ),
                  padding: EdgeInsets.all(16.0), // Aumenta el padding del botón para hacerlo más grande
                ),
                child: Text(
                  'Ingredientes',
                  style: TextStyle(fontSize: 20.0), // Aumenta el tamaño del texto
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}