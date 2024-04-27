import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:proyecto_tsp_dev/Model/recetadb.dart';

class DRReceta {
  final Database _database;

  DRReceta(this._database);


  // Obtener la lista de recetas
  Future<List<Receta>> getRecetas() async {
    List<Map<String, dynamic>> tables = await _database.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    print("Tablas en la base de datos: $tables");
    List<Map<String, dynamic>> recetasMap = await _database.query('Recetas');
    return recetasMap
        .map((e) => Receta(
            id: e['id_receta'],
            nombre: e['nombre_receta'],
            imagen: e['imagen_receta'],
            preparacion: e['Preparacion_receta'],
            favoritos: e['favoritos']))
        .toList();
  } // Pito

  // Agregar una nueva receta
  Future<void> addReceta(Receta receta) async {
    await _database.insert('Recetas', receta.toMap());
  }

  // Obtener nombre de una receta por su ID
  Future<String?> obtenerNombreReceta(int idReceta) async {
    final result = await _database.query('Recetas', where: 'id_receta = ?', whereArgs: [idReceta]);
    if (result.isNotEmpty) {
      return result.first['nombre_receta'] as String?;
    }
    return null;
  }

  // Obtener imagen de una receta por su ID
  Future<String?> obtenerImagenReceta(int idReceta) async {
    final result = await _database.query('Recetas', where: 'id_receta = ?', whereArgs: [idReceta]);
    if (result.isNotEmpty) {
      return result.first['imagen_receta'] as String?;
    }
    return null;
  }

  // Obtener preparación de la receta por su ID
  Future<String?> obtenerPreparacionReceta(int idReceta) async {
    final result = await _database.query('Recetas', where: 'id_receta = ?', whereArgs: [idReceta]);
    if (result.isNotEmpty) {
      return result.first['Preparacion_receta'] as String?;
    }
    return null;
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
}
