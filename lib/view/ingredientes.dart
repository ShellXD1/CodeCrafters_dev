import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';

class IngredientesView extends StatefulWidget {
  final IngredienteViewModel? ingredientViewModel;
  final dynamic database;

  const IngredientesView({Key? key, required this.ingredientViewModel, required this.database})
      : super(key: key);

  @override
  _IngredientesViewState createState() => _IngredientesViewState();
}

class _IngredientesViewState extends State<IngredientesView> {
  bool _ingredientesCargados = false;

  @override
  void initState() {
    super.initState();
    if (widget.ingredientViewModel != null) {
      widget.ingredientViewModel!.obtenerIngredientesNoVacios().then((_) {
        setState(() {
          _ingredientesCargados = true;
        });
      });
    }
  }

   void _showIngredientDetailDialog(Ingrediente ingrediente) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _cantidadController = TextEditingController(text: ingrediente.cantidad.toString());

        return AlertDialog(
          title: Text('Detalles del Ingrediente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${ingrediente.nombre}'),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cantidadController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Cantidad',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (_cantidadController.text.isNotEmpty) {
                            int currentCantidad = int.parse(_cantidadController.text);
                            if (currentCantidad > 0) {
                              _cantidadController.text = (currentCantidad - 1).toString();
                            }
                          }
                        },
                        icon: Icon(Icons.remove),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_cantidadController.text.isNotEmpty) {
                            int currentCantidad = int.parse(_cantidadController.text);
                            _cantidadController.text = (currentCantidad + 1).toString();
                          }
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                widget.ingredientViewModel?.quitarCantidadIngrediente(ingrediente, 0);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => IngredientesView(ingredientViewModel: widget.ingredientViewModel, database: widget.database)),
                );
              },
              child: Text('Eliminar'),
            ),
            TextButton(
              onPressed: () {
                int newCantidad = int.parse(_cantidadController.text);
                widget.ingredientViewModel?.agregarCantidadIngrediente(ingrediente, newCantidad);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => IngredientesView(ingredientViewModel: widget.ingredientViewModel, database: widget.database)),
                );
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ingredientes',
          style: TextStyle(fontSize: 30.0, fontFamily: 'Chivo'),
        ),
        leading: IconButton(
          icon: Icon(Icons.home, size: 40.0),
          onPressed: () {
            print("Botón de la casita presionado (regresar a la pantalla de inicio)");
            Navigator.pop(context);
          },
        ),
      ),
      body: _ingredientesCargados
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Mis Ingredientes',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    children: widget.ingredientViewModel!.ingredientes.map((ingrediente) {
                      return GestureDetector(
                        onTap: () {
                          _showIngredientDetailDialog(ingrediente);
                        },
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ingrediente.nombre,
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Cantidad: ${ingrediente.cantidad}',
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
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
                        print('Nombre del ingrediente: $name, Cantidad: $quantity');
                        setState(() {});
                      },
                      ingredientViewModel: widget.ingredientViewModel,
                      database: widget.database,
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
                      print("Botón 'Recetas' presionado");
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                      Navigator.pushNamed(context,'/recetas');
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

class AgregarIngredienteWidget extends StatefulWidget {
  final IngredienteViewModel? ingredientViewModel;
  final Function(String name, int quantity) onIngredientAdded;
  final dynamic database;

  const AgregarIngredienteWidget({
    Key? key,
    required this.onIngredientAdded,
    this.ingredientViewModel,
    this.database,
  }) : super(key: key);

  @override
  _AgregarIngredienteWidgetState createState() => _AgregarIngredienteWidgetState();
}

class _AgregarIngredienteWidgetState extends State<AgregarIngredienteWidget> {
  String? _selectedIngredient;
  int _quantity = 0;
  bool _ingredientesCargados = false;

  @override
  void initState() {
    super.initState();
    if (widget.ingredientViewModel != null) {
      widget.ingredientViewModel!.obtenerIngredientesVacios().then((_) {
        setState(() {
          _ingredientesCargados = true;
        });
      });
    }
  }

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
          child: _ingredientesCargados
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedIngredient,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedIngredient = newValue;
                        });
                      },
                      items: widget.ingredientViewModel!.ingredientes
                          .map((Ingrediente ingrediente) {
                        return DropdownMenuItem<String>(
                          value: ingrediente.nombre,
                          child: Text(ingrediente.nombre),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Selecciona un ingrediente',
                      ),
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
                        if (_selectedIngredient != null &&
                            _selectedIngredient!.isNotEmpty) {
                          widget.ingredientViewModel?.agregarCantidadIngredienteNombre(_selectedIngredient!, _quantity);
                          widget.onIngredientAdded(_selectedIngredient!, _quantity);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => IngredientesView(ingredientViewModel: widget.ingredientViewModel, database: widget.database)),
                          );
                        } else {
                          // Handle error or empty selection
                        }
                      },
                      child: Text('Agregar'),
                    ),
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
