import 'package:proyecto_tsp_dev/Model/DR_ListIngre.dart';
import 'package:proyecto_tsp_dev/Model/ListaIngredientesdb.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;
import 'package:sqflite_common/sqlite_api.dart';

class MLista {
  final DRLista _repository;

  MLista(Database database) : _repository = DRLista(database);

  // Método para obtener la lista_Ingredientes
  Future<List<ListIng>> obtenerIngredientes() async {
    return _repository.getListaIngredientes();
  }

}
