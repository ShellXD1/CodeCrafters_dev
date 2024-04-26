import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:sqflite_common/sqlite_api.dart';

class IngredientesView extends StatelessWidget {
  final IngredienteViewModel ingredientViewModel;

  const IngredientesView({Key? key, required this.ingredientViewModel, required Database database})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingredientes',
            style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo')),
        leading: IconButton(
          icon: Icon(Icons.home, size: 40.0),
          onPressed: () {
            print(
                "Botón de la casita presionado (regresar a la pantalla de inicio)");
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Ingredientes:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontFamily: 'Chivo'),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      // Utiliza la lista de ingredientes del view model
                      for (var ingredient in ingredientViewModel.ingredientes)
                        IngredientCard(
                          quantity: ingredient.cantidad,
                          name: ingredient.nombre,
                          onTap: () {
                            final TextEditingController _quantityController =
                                TextEditingController(
                                    text: ingredient.cantidad.toString());

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Modificar Cantidad',
                                    style: TextStyle(fontFamily: 'Chivo'),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: _quantityController,
                                        keyboardType: TextInputType.number,
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              int currentValue = int.tryParse(
                                                      _quantityController
                                                          .text) ??
                                                  ingredient.cantidad;
                                              _quantityController.text =
                                                  (currentValue - 1).toString();
                                            },
                                            child: Icon(Icons.remove),
                                          ),
                                          SizedBox(width: 10.0),
                                          ElevatedButton(
                                            onPressed: () {
                                              int currentValue = int.tryParse(
                                                      _quantityController
                                                          .text) ??
                                                  ingredient.cantidad;
                                              _quantityController.text =
                                                  (currentValue + 1).toString();
                                            },
                                            child: Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Cancelar',
                                        style: TextStyle(fontFamily: 'Chivo'),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Aquí puedes hacer lo que necesites con la nueva cantidad
                                        int newQuantity = int.tryParse(
                                                _quantityController.text) ??
                                            ingredient.cantidad;
                                        print(
                                            'Nueva cantidad para ${ingredient.nombre}: $newQuantity');
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Guardar',
                                        style: TextStyle(fontFamily: 'Chivo'),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF9EE060),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return AgregarIngredienteWidget(
                      onIngredientAdded: (name, quantity) {
                        // Lógica para agregar el ingrediente aquí
                        print(
                            'Nombre del ingrediente: $name, Cantidad: $quantity');
                        // Puedes actualizar el estado de la lista de ingredientes aquí
                      },
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9EE060),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              child: Text(
                'Agregar Ingrediente',
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Chivo',
                  color: Colors.black,
                ),
              ),
            ),
            Row(
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
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Chivo',
                        color: Colors.black,
                      ),
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
                      backgroundColor: Color(0xFF9EE060),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: EdgeInsets.all(16.0),
                    ),
                    child: Text(
                      'Ingredientes',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Chivo',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IngredientCard extends StatelessWidget {
  final int quantity;
  final String name;
  final VoidCallback onTap;

  const IngredientCard({
    Key? key,
    required this.quantity,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blueGrey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Quantity: $quantity',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AgregarIngredienteWidget extends StatefulWidget {
  final Function(String name, int quantity) onIngredientAdded;

  const AgregarIngredienteWidget({Key? key, required this.onIngredientAdded})
      : super(key: key);

  @override
  _AgregarIngredienteWidgetState createState() =>
      _AgregarIngredienteWidgetState();
}

class _AgregarIngredienteWidgetState extends State<AgregarIngredienteWidget> {
  String _selectedIngredient =
      'Seleccione un ingrediente'; // Valor predeterminado
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blueGrey, width: 2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedIngredient,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedIngredient = newValue!;
                  });
                },
                items: <String>[
                  'Seleccione un ingrediente', // Valor predeterminado
                  'Ingrediente 1',
                  'Ingrediente 2',
                  'Ingrediente 3',
                  // Agrega más ingredientes según sea necesario
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration:
                    InputDecoration(labelText: 'Selecciona un ingrediente'),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _quantity = int.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  if (_selectedIngredient != 'Seleccione un ingrediente') {
                    widget.onIngredientAdded(_selectedIngredient, _quantity);
                    Navigator.pop(
                        context); // Cerrar el widget de agregar ingrediente
                  } else {
                    // Puedes mostrar un mensaje de error o manejar la situación de otra manera
                  }
                },
                child: Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
