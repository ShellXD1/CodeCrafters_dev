import 'package:proyecto_tsp_dev/Model/DR_ListIngre.dart';
import 'package:proyecto_tsp_dev/Model/ListaIngredientesdb.dart';
import 'package:sqflite/sqflite.dart';

class MLista {
  final DRLista _repository;

  MLista(Database database) : _repository = DRLista(database);

  // Método para agregar la cantidad de un ingrediente
  Future<void> agregarCantidadIngrediente(
      ListIng listaIng, int cantidad) async {
    await _repository.agregarCantidadIngrediente(listaIng, cantidad);
  }

  // Método para quitar la cantidad de un ingrediente
  Future<void> quitarCantidadIngrediente(ListIng listaIng, int cantidad) async {
    await _repository.quitarCantidadIngrediente(listaIng, cantidad);
  }
}
