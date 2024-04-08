import 'package:sqflite/sqflite.dart';
import 'package:proyecto_tsp_dev/Model/ListaIngredientesdb.dart';

class DRLista {
  final Database _database;

  DRLista(this._database);

  // Obtener lista de lista de ingredientes por preparación
  Future<List<ListIng>> getListaIng() async {
    List<Map<String, dynamic>> listaIngMap =
        await _database.query('Ingredientes');
    return listaIngMap
        .map((e) => ListIng(
            idList: e['id_lis_ing'],
            idIng: e['id_ing'],
            cantidad: e['cantidad_lis_ing']))
        .toList();
  }

  // Agrega una cantidad  de  algun ingrediente a la base de datos
  Future<void> agregarCantidadIngrediente(
      ListIng listaIng, int cantidad) async {
    await _database.rawUpdate('''
      UPDATE Lista_ingredientes
      SET cantidad_lis_ing = cantidad_lis_ing + ?
      WHERE id_ing = ?
    ''', [cantidad, listaIng.idIng]);
  }

  // Quita una cantidad  de  algun ingrediente a la base de datos
  Future<void> quitarCantidadIngrediente(ListIng listaIng, int cantidad) async {
    await _database.rawUpdate('''
      UPDATE Lista_ingredientes
      SET cantidad_lis_ing = cantidad_lis_ing - ?
      WHERE id_ing = ? AND cantidad_lis_ing >= ?
    ''', [cantidad, listaIng.idIng, cantidad]);
  }
}
