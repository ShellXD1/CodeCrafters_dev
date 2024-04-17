import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/Model/M_Ingrediente.dart';
import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';

class IngredienteViewModel extends ChangeNotifier{
  final MIngrediente _mIngredientes;

  IngredienteViewModel(this._mIngredientes);


  List<Ingrediente> _ingredientes = [];
  List<Ingrediente> get ingredientes => _ingredientes;

  // Método para obtener los ingredientes
  Future<void> obtenerIngredientes() async {
    _ingredientes = await _mIngredientes.obtenerIngredientes();
    notifyListeners();
  }

  // Método para agregar la cantidad de un ingrediente a la lista
  void agregarCantidadIngrediente(Ingrediente ingrediente, int cantidad) {
    int index = _ingredientes.indexWhere((i) => i.id == ingrediente.id);
    if (index != -1) {
      _ingredientes[index].cantidad += cantidad;
    } else {
      // Si el ingrediente no está en la lista, lo agregamos con la cantidad especificada
      ingrediente.cantidad = cantidad;
      _ingredientes.add(ingrediente);
    }
    // Actualizamos en la base de datos
    _mIngredientes.agregarCantidadIngrediente(ingrediente as int, cantidad);
    notifyListeners();
  }

  // Método para quitar la cantidad de un ingrediente de la lista
  void quitarCantidadIngrediente(Ingrediente ingrediente, int cantidad) {
    int index = _ingredientes.indexWhere((i) => i.id == ingrediente.id);
    if (index != -1) {
      _ingredientes[index].cantidad -= cantidad;
      if (_ingredientes[index].cantidad <= 0) {
        _ingredientes.removeAt(index);
      }
      // Actualizamos en la base de datos
      _mIngredientes.quitarCantidadIngrediente(ingrediente as int, cantidad);
      notifyListeners();
    }
  }
}

