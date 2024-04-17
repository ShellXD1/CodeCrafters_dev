import 'package:proyecto_tsp_dev/Model/DR_ListIngre.dart';
import 'package:proyecto_tsp_dev/Model/ListaIngredientesdb.dart';
import 'package:sqflite/sqflite.dart';

class MLista {
  final DRLista _repository;

  MLista(Database database) : _repository = DRLista(database);

  // Método para obtener la lista_Ingredientes
  Future<List<ListIng>> obtenerIngredientes() async {
    return _repository.getListaIngredientes();
  }
}
