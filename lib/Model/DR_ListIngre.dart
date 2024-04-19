import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;
import 'package:sqflite_common/sqlite_api.dart';
import 'package:proyecto_tsp_dev/Model/ListaIngredientesdb.dart';

class DRLista {
  final Database _database;

  DRLista(this._database);

  // Obtener la lista de lista_ingredientes
  Future<List<ListIng>> getListaIngredientes() async {
    List<Map<String, dynamic>> ListaIngMap =
        await _database.query('Lista_Ingredientes');
    return ListaIngMap.map((e) => ListIng(
        idList: e['idList'],
        cantidad: e['cantidad'],
        idIng: e['idIng'],
        idreceta: e['idreceta'])).toList();
  }
}
