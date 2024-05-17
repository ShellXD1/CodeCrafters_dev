import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';
import 'package:proyecto_tsp_dev/view/recetas.dart';
import 'package:proyecto_tsp_dev/viewModel/ingredientViewModel.dart';
import 'package:proyecto_tsp_dev/viewModel/recetasViewModel.dart';

class IngredientesView extends StatefulWidget {
  final IngredienteViewModel ingredientViewModel;
  final RecetasViewModel recetasViewModel;
  final dynamic database;

  const IngredientesView({Key? key, required this.ingredientViewModel, required this.database, required this.recetasViewModel})
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
                  MaterialPageRoute(builder: (context) => IngredientesView(ingredientViewModel: widget.ingredientViewModel, database: widget.database, recetasViewModel: widget.recetasViewModel,)),
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
                  MaterialPageRoute(builder: (context) => IngredientesView(ingredientViewModel: widget.ingredientViewModel, database: widget.database, recetasViewModel: widget.recetasViewModel,)),
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
    int _selectedIndex = 1; // Este indice permite que el bottomNavigationBar distinga en que lugar esta
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
        
        //Aqui deberia ir el
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                // Al presionar el botón, se muestra el widget para agregar un ingrediente
                showDialog(
                  context: context,
                  builder: (context) => AgregarIngredienteWidget(
                    onIngredientAdded: (String name, int quantity) {  }, 
                    ingredientViewModel: widget.ingredientViewModel, 
                    recetasViewModel: widget.recetasViewModel,), // Aquí invocamos el widget para agregar un ingrediente
                );
              },
              icon: Icon(Icons.add), // Ícono del botón
              label: Text('Agregar ingrediente'), // Texto del botón
              backgroundColor: Color.fromARGB(255, 224, 200, 110), // Cambia el color del botón a azul
        ),

      //Desde este punto esta el navigationBar, no se logro implementar cierta persistencia, por lo cual es importante copiar este y pegarlo
      //en las vistas que se creen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecetasView(
                    recetasViewModel: widget.recetasViewModel,
                    database: null, ingredientesViewModel: widget.ingredientViewModel, // Assuming you don't need database here
                  ),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IngredientesView(
                    ingredientViewModel: widget.ingredientViewModel,
                    database: widget.database, recetasViewModel: widget.recetasViewModel,
                  ),
                ),
              );
              break;
          }
        },
      ),



      /*bottomNavigationBar: Container(
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
      ),*/






    );
  }
}

class AgregarIngredienteWidget extends StatefulWidget {
  final RecetasViewModel recetasViewModel;
  final IngredienteViewModel ingredientViewModel;
  final Function(String name, int quantity) onIngredientAdded;
  final dynamic database;

  const AgregarIngredienteWidget({
    Key? key,
    required this.onIngredientAdded,
    required this.ingredientViewModel,
    this.database,
    required this.recetasViewModel,
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
      child: _buildAlertDialog(context),
    );
  }

  Widget _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text('Agregar Ingrediente'),
      content: _ingredientesCargados
          ? SingleChildScrollView(
              child: Column(
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
                ],
              ),
            )
          : CircularProgressIndicator(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_selectedIngredient != null && _selectedIngredient!.isNotEmpty) {
              widget.ingredientViewModel?.agregarCantidadIngredienteNombre(_selectedIngredient!, _quantity);
              widget.onIngredientAdded(_selectedIngredient!, _quantity);
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => IngredientesView(
                    ingredientViewModel: widget.ingredientViewModel,
                    database: widget.database,
                    recetasViewModel: widget.recetasViewModel,
                  ),
                ),
              );
            } else {
              // Manejar error o selección vacía
            }
          },
          child: Text('Agregar'),
        ),
      ],
    );
  }
}
