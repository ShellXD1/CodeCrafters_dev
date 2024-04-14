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
            id: e['id_ing'],
            nombre: e['nombre_ing'],
            imagen: e['imagen_ing'],
            cantidad: e['cantidad']))
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
            id: e['id_ing'],
            nombre: e['nombre_ing'],
            imagen: e['imagen_ing'],
            cantidad: e['cantidad']))
        .toList();
  }

  // Método para obtener la lista de ingredientes por preparación
  Future<List<Ingrediente>> obtenerIngredientesPorPreparacion(
      int idPreparacion) async {
    final List<Map<String, dynamic>> ingredientesPorPreparacion =
        await _database.rawQuery('''
      SELECT Ingredientes.id_ing, Ingredientes.nombre_ing, Ingredientes.cantidad
      FROM Ingredientes
      INNER JOIN Lista_ingredientes ON Ingredientes.id_ing = Lista_ingredientes.id_ing
      WHERE Lista_ingredientes.id_pre = ?
    ''', [idPreparacion]);

    return ingredientesPorPreparacion
        .map((ingrediente) => Ingrediente(
              id: ingrediente['id_ing'],
              nombre: ingrediente['nombre_ing'],
              imagen: ingrediente['imagen_ing'],
              cantidad: ingrediente['cantidad'],
            ))
        .toList();
  }

  // Método para agregar cantidad a un ingrediente
  Future<void> agregarCantidadIngrediente(
      int idIngrediente, int cantidad) async {
    await _database.rawUpdate('''
      UPDATE Ingredientes
      SET cantidad = cantidad + ?
      WHERE id_ing = ?
    ''', [cantidad, idIngrediente]);
  }

  // Método para quitar cantidad a un ingrediente
  Future<void> quitarCantidadIngrediente(
      int idIngrediente, int cantidad) async {
    await _database.rawUpdate('''
      UPDATE Ingredientes
      SET cantidad = GREATEST(0, cantidad - ?)
      WHERE id_ing = ?
    ''', [cantidad, idIngrediente]);
  }
}
