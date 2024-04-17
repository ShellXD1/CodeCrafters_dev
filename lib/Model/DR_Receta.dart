import 'package:sqflite/sqflite.dart';
import 'package:proyecto_tsp_dev/Model/recetadb.dart';

class DRReceta {
  final Database _database;

  DRReceta(this._database);

  // Obtener la lista de recetas
  Future<List<Receta>> getRecetas() async {
    List<Map<String, dynamic>> recetasMap = await _database.query('Recetas');
    return recetasMap
        .map((e) => Receta(
            id: e['id_receta'],
            nombre: e['nombre_receta'],
            imagen: e['imagen_receta'],
            preparacion: e['Preparacion_receta']))
        .toList();
  }

  // Agregar una nueva receta
  Future<void> addReceta(Receta receta) async {
    await _database.insert('Recetas', receta.toMap());
  }

// Obtener nombre de una receta por su ID
  Future<String?> obtenerNombreReceta(int idReceta) async {
    final result = await _database
        .query('Recetas', where: 'id_receta = ?', whereArgs: [idReceta]);
    if (result.isNotEmpty) {
      return result.first['nombre_receta'] as String?;
    }
    return null;
  }

  // Obtener imagen de una receta por su ID
  Future<String?> obtenerImagenReceta(int idReceta) async {
    final result = await _database
        .query('Recetas', where: 'id_receta = ?', whereArgs: [idReceta]);
    if (result.isNotEmpty) {
      return result.first['imagen_receta'] as String?;
    }
    return null;
  }

  // Obtener preparación de la receta por su ID
  Future<String?> obtenerPreparacionReceta(int idReceta) async {
    final result = await _database
        .query('Recetas', where: 'id_receta = ?', whereArgs: [idReceta]);
    if (result.isNotEmpty) {
      return result.first['Preparacion_receta'] as String?;
    }
    return null;
  }
}
