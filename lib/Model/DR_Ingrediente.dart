import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;
import 'package:sqflite_common/sqlite_api.dart';
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
            id: e['id_ingrediente'],
            nombre: e['nombre_ing'],
            imagen: e['imagen_ing'],
            cantidad: e['Cantidad'],
            medida: e['medida']))
        .toList();
  }

Future<List<Ingrediente>> getIngredientesNoVacios() async {
  List<Map<String, dynamic>> ingredientesMap =
      await _database.rawQuery('SELECT * FROM Ingredientes WHERE cantidad > 0');
  return ingredientesMap
      .map((e) => Ingrediente(
          id: e['id_ingrediente'],
          nombre: e['nombre_ing'],
          imagen: e['imagen_ing'],
          cantidad: e['Cantidad'],
          medida: e['medida']))
      .toList();
}

Future<List<Ingrediente>> getIngredientesVacios() async {
  List<Map<String, dynamic>> ingredientesMap =
      await _database.rawQuery('SELECT * FROM Ingredientes WHERE cantidad <= 0');
  return ingredientesMap
      .map((e) => Ingrediente(
          id: e['id_ingrediente'],
          nombre: e['nombre_ing'],
          imagen: e['imagen_ing'],
          cantidad: e['Cantidad'],
          medida: e['medida']))
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
            cantidad: e['cantidad'],
            medida: e['medida']))
        .toList();
  }

  // Método para obtener la lista de ingredientes por preparación
  Future<List<Ingrediente>> obtenerIngredientesPorPreparacion(
      int idPreparacion) async {
    final List<Map<String, dynamic>> ingredientesPorPreparacion =
        await _database.rawQuery('''
      SELECT Ingredientes.id_ingrediente, Ingredientes.nombre_ing, Ingredientes.cantidad
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
            medida: ingrediente['medida']))
        .toList();
  }

  // Método para agregar cantidad a un ingrediente
  Future<void> agregarCantidadIngrediente(
      int idIngrediente, int cantidad) async {
    await _database.rawUpdate('''
      UPDATE Ingredientes
      SET cantidad =  ?
      WHERE id_ingrediente = ?
    ''', [cantidad, idIngrediente]);
  }

  // Método para agregar cantidad a un ingrediente por nombre
  Future<void> agregarCantidadIngredienteNombre(
      String nombreIngrediente, int cantidad) async {
    await _database.rawUpdate('''
      UPDATE Ingredientes
      SET cantidad = cantidad + ?
      WHERE nombre_ing = ?
    ''', [cantidad, nombreIngrediente]);
  }

  // Método para quitar cantidad a un ingrediente
  Future<void> quitarCantidadIngrediente(
      int idIngrediente) async {
    await _database.rawUpdate('''
      UPDATE Ingredientes
      SET cantidad = 0
      WHERE id_ingrediente = ?
    ''', [idIngrediente]);
  }

  // Método para quitar cantidad a un ingrediente por Nombre
  Future<void> quitarCantidadIngredienteNombre(
      String nombreIngrediente, int cantidad) async {
    await _database.rawUpdate('''
      UPDATE Ingredientes
      SET cantidad = GREATEST(0, cantidad - ?)
      WHERE nombre_ing = ?
    ''', [cantidad, nombreIngrediente]);
  }

  // Obtener recetas disponibles a partir de los ingredientes disponibles
  Future<List<Map<String, dynamic>>> getRecetasDisponibles(List<String> ingredientesDisponibles) async {
    final List<Map<String, dynamic>> recetasDisponibles = await _database.rawQuery('''
      SELECT r.* FROM Recetas r
      INNER JOIN Receta_Ingrediente ri ON r.id_receta = ri.id_receta
      WHERE ri.nombre_ingrediente IN (${ingredientesDisponibles.map((e) => "'$e'").join(',')})
      GROUP BY r.id_receta
      HAVING COUNT(DISTINCT ri.nombre_ingrediente) = ${ingredientesDisponibles.length}
    ''');
    return recetasDisponibles;
  }

  //Obtener ingredientes de las recetas
  Future<List<Map<String, dynamic>>> getIngredientesReceta(
  int receta
  ) async {
    final List<Map<String, dynamic>> ingredientesReceta =
        await _database.rawQuery('''
    SELECT i.nombre_ing, li.cantidad_ingrediente, i.medida
    FROM Ingredientes i
    JOIN Lista_Ingredientes li ON i.id_ingrediente = li.id_ingrediente
    WHERE li.id_receta = ?;
    ''', [receta]);
    return ingredientesReceta;
  }
}
