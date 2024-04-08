import 'package:sqflite/sqflite.dart';
import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';

class DRIngrediente {
  final Database _database;

  DRIngrediente(this._database);

  // Obtener la lista de ingredientes
  Future<List<Ingrediente>> getIngredientes() async {
    List<Map<String, dynamic>> ingredientesMap =
        await _database.query('Ingredientes');
    return ingredientesMap
        .map((e) => Ingrediente(
            id: e['id_ing'], nombre: e['nombre_ing'], imagen: e['imagen_ing']))
        .toList();
  }

  // Obtener la lista de ingredientes para una receta específica
  Future<List<Ingrediente>> getIngredientesPorReceta(int idReceta) async {
    List<Map<String, dynamic>> listaIngredientesMap =
        await _database.rawQuery('''
      SELECT Ingredientes.*
      FROM Ingredientes
      INNER JOIN Lista_ingredientes ON Ingredientes.id_ing = Lista_ingredientes.id_ing
      WHERE Lista_ingredientes.id_receta = ?
    ''', [idReceta]);
    return listaIngredientesMap
        .map((e) => Ingrediente(
            id: e['id_ing'], nombre: e['nombre_ing'], imagen: e['imagen_ing']))
        .toList();
  }
}
