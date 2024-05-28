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

  // Método para obtener los ingredientes no vacios
  Future<void> obtenerIngredientesNoVacios() async {
    _ingredientes = await _mIngredientes.obtenerIngredientesNoVacios();
    notifyListeners();
  }

  // Método para obtener los ingredientes vacios
  Future<void> obtenerIngredientesVacios() async {
    _ingredientes = await _mIngredientes.obtenerIngredientesVacios();
    notifyListeners();
  }

  // Método para obtener los ingredientes vacios
  Future<void> obtenerIngredientesPorPreparacion(int idPreparacion) async {
    _ingredientes = await _mIngredientes.obtenerIngredientesPorPreparacion(idPreparacion);
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
    _mIngredientes.agregarCantidadIngrediente(ingrediente.id, cantidad);
    notifyListeners();
  }

  // Método para agregar la cantidad de un ingrediente a la lista por nombre
  void agregarCantidadIngredienteNombre(String nombreIngrediente, int cantidad) {
    int index = _ingredientes.indexWhere((i) => i.nombre == nombreIngrediente);
    if (index != -1) {
      _ingredientes[index].cantidad += cantidad;
    }
    // Actualizamos en la base de datos
    _mIngredientes.agregarCantidadIngredienteNombre(nombreIngrediente, cantidad);
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
      _mIngredientes.quitarCantidadIngrediente(ingrediente.id, cantidad);
      notifyListeners();
    }
  }

  Future<List<Ingrediente>> obtenerTresIngredientesMenosCantidad() async {
  List<Ingrediente> ingredientes = await _mIngredientes.obtenerIngredientesNoVacios(); // Obtener todos los ingredientes
  ingredientes.sort((a, b) => a.cantidad.compareTo(b.cantidad)); // Ordenar los ingredientes por cantidad
  return ingredientes.take(3).toList(); // Tomar los tres primeros ingredientes (con menor cantidad)
  }

  // Función para obtener las recetas disponibles a partir de los ingredientes disponibles y son Desayunos
  Future<List<Map<String, dynamic>>> getIngredientesReceta(
      int receta) async {
    return await _mIngredientes
        .getIngredientesReceta(receta);
  }

}

