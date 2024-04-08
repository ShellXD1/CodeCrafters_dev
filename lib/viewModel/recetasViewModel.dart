import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/Model/ListaIngredientesdb.dart';
import 'package:proyecto_tsp_dev/Model/M_Ingrediente.dart';
import 'package:proyecto_tsp_dev/Model/M_ListaIng.dart';
import 'package:proyecto_tsp_dev/Model/M_Receta.dart';
import 'package:proyecto_tsp_dev/Model/recetadb.dart';

class RecetasViewModel extends ChangeNotifier {
  final MIngrediente _mIngredientes;
  final MReceta _mRecetas;
  final MLista _mLista;

  RecetasViewModel(this._mIngredientes, this._mRecetas, this._mLista);

  List<Receta> _recetas = [];
  List<Receta> get recetas => _recetas;

  List<ListIng> _listaIngredientes = [];
  List<ListIng> get listaIngredientes => _listaIngredientes;

  // Método para obtener las recetas
  Future<void> obtenerRecetas() async {
    _recetas = await _mRecetas.obtenerRecetas();
    notifyListeners();
  }

  // Método para obtener los ingredientes
  Future<void> obtenerIngredientes() async {
    _listaIngredientes =
        (await _mIngredientes.obtenerIngredientes()).cast<ListIng>();
    notifyListeners();
  }

  // Método para agregar la cantidad de un ingrediente a la lista
  void agregarCantidadIngrediente(ListIng listaIng, int cantidad) {
    int index = _listaIngredientes.indexWhere((i) => i.idIng == listaIng.idIng);
    if (index != -1) {
      _listaIngredientes[index].cantidad += cantidad;
    } else {
      // Si el ingrediente no está en la lista, lo agregamos con la cantidad especificada
      _listaIngredientes
          .add(ListIng(idList: 0, idIng: listaIng.idIng, cantidad: cantidad));
    }
    _mLista.agregarCantidadIngrediente(
        listaIng, cantidad); // Actualizamos en la base de datos
    notifyListeners();
  }

  // Método para quitar la cantidad de un ingrediente de la lista
  void quitarCantidadIngrediente(ListIng listaIng, int cantidad) {
    int index = _listaIngredientes.indexWhere((i) => i.idIng == listaIng.idIng);
    if (index != -1) {
      _listaIngredientes[index].cantidad -= cantidad;
      if (_listaIngredientes[index].cantidad <= 0) {
        _listaIngredientes.removeAt(index);
      }
      _mLista.quitarCantidadIngrediente(
          listaIng, cantidad); // Actualizamos en la base de datos
      notifyListeners();
    }
  }
}
