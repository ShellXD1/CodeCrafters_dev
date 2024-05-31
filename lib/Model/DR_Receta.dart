import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:proyecto_tsp_dev/Model/recetadb.dart';

class DRReceta {
  final Database _database;

  DRReceta(this._database);

  // Obtener la lista de recetas
  Future<List<Receta>> getRecetas() async {
    List<Map<String, dynamic>> recetasMap =
        await _database.query('Recetas', orderBy: 'nombre_receta ASC');
    return recetasMap
        .map((e) => Receta(
            id: e['id_receta'],
            nombre: e['nombre_receta'],
            imagen: e['imagen_receta'],
            preparacion: e['Preparacion_receta'],
            favoritos: e['favoritos'],
            clasificacion: e['clasificacion'],
            informacion: e['info_nutricional']))
        .toList();
  }

  //ORDER BY nombre_ing ASC

  Future<List<Receta>> getRecetasPorClasificacion(String clasificacion) async {
    try {
      List<Map<String, dynamic>> recetasMap = await _database.query('Recetas',
          where: 'clasificacion = ?',
          whereArgs: [clasificacion],
          orderBy: 'nombre_receta ASC');

      return recetasMap
          .map((e) => Receta(
              id: e['id_receta'],
              nombre: e['nombre_receta'],
              imagen: e['imagen_receta'],
              preparacion: e['Preparacion_receta'],
              favoritos: e['favoritos'],
              clasificacion: e['clasificacion'],
              informacion: e['info_nutricional']))
          .toList();
    } catch (e) {
      // Manejo de errores
      print('Error al obtener recetas por clasificación: $e');
      return [];
    }
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

  // Obtener recetas disponibles a partir de los ingredientes disponibles
  Future<List<Map<String, dynamic>>> getRecetasDisponibles(
    List<String> ingredientesDisponibles,
  ) async {
    final List<Map<String, dynamic>> recetasDisponibles =
        await _database.rawQuery('''
    SELECT *
    FROM Recetas r
    WHERE EXISTS (
        SELECT *
        FROM Lista_Ingredientes li
        LEFT JOIN Ingredientes i ON li.id_ingrediente = i.id_ingrediente
        WHERE li.id_receta = r.id_receta AND (i.cantidad > 0)
        ) ORDER BY nombre_receta ASC
    ''');
    return recetasDisponibles;
  }

  // Método para obtener la lista de ingredientes por preparación
  Future<String?> obtenerIngredientesReceta(int idReceta) async {
    final result = await _database
        .query('Recetas', where: 'id_receta = ?', whereArgs: [idReceta]);
    if (result.isNotEmpty) {
      return result.first['ingredientes'] as String?;
    }
    return null;
  }

  // Método para obtener las recetas favoritas
  Future<List<Receta>> obtenerRecetaFavoritas() async {
    List<Map<String, dynamic>> recetasMap = await _database.rawQuery(
      'SELECT * FROM Recetas WHERE favoritos = 1 ORDER BY nombre_receta ASC',
    );
    return recetasMap
        .map((e) => Receta(
            id: e['id_receta'],
            nombre: e['nombre_receta'],
            imagen: e['imagen_receta'],
            preparacion: e['Preparacion_receta'],
            favoritos: e['favoritos'],
            clasificacion: e['clasificacion'],
            informacion: e['info_nutricional']))
        .toList();
  }

  // Métodos para marcar una receta como favorita
  Future<void> marcarRecetaComoFavorita(int idReceta) async {
    await _database.update(
      'Recetas',
      {'favoritos': 1},
      where: 'id_receta = ?',
      whereArgs: [idReceta],
    );
  }

  // Método para eliminar una receta de favoritos
  Future<void> eliminarRecetaDeFavoritos(int idReceta) async {
    await _database.update(
      'Recetas',
      {'favoritos': 0},
      where: 'id_receta = ?',
      whereArgs: [idReceta],
    );
  }

  // Método para comprobar si una receta es favorita
  Future<bool> esRecetaFavorita(int idReceta) async {
    // Realizar la consulta a la base de datos para obtener el valor de 'favoritos'
    final result = await _database.query(
      'Recetas',
      columns: ['favoritos'],
      where: 'id_receta = ?',
      whereArgs: [idReceta],
    );
    // Verificar si se encontró un registro para la receta
    if (result.isNotEmpty) {
      // Obtener el valor de 'favoritos' del primer registro
      final favoritos = result.first['favoritos'] as int?;
      // Verificar si el valor de 'favoritos' es 1 (favorita)
      if (favoritos != null && favoritos == 1) {
        return true;
      }
    }
    // Si no se encontró un registro o 'favoritos' es distinto de 1, se asume que no es favorita
    return false;
  }

  // Obtener recetas disponibles a partir de los ingredientes disponibles y que sean Desayunos
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesDesayunos(
    List<String> ingredientesDisponibles,
  ) async {
    final List<Map<String, dynamic>> recetasDisponibles =
        await _database.rawQuery('''
    SELECT *
    FROM Recetas r
    WHERE r.clasificacion = 'Desayuno' AND EXISTS (
        SELECT *
        FROM Lista_Ingredientes li
        LEFT JOIN Ingredientes i ON li.id_ingrediente = i.id_ingrediente
        WHERE li.id_receta = r.id_receta AND (i.cantidad > 0)
        ) ORDER BY nombre_receta ASC
    ''');
    return recetasDisponibles;
  }

  // Obtener recetas disponibles a partir de los ingredientes disponibles y que sean Comidas
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesComidas(
    List<String> ingredientesDisponibles,
  ) async {
    final List<Map<String, dynamic>> recetasDisponibles =
        await _database.rawQuery('''
    SELECT *
    FROM Recetas r
    WHERE r.clasificacion = 'Comida' AND EXISTS (
        SELECT *
        FROM Lista_Ingredientes li
        LEFT JOIN Ingredientes i ON li.id_ingrediente = i.id_ingrediente
        WHERE li.id_receta = r.id_receta AND (i.cantidad > 0)
        ) ORDER BY nombre_receta ASC
    ''');
    return recetasDisponibles;
  }

  // Obtener recetas disponibles a partir de los ingredientes disponibles y que sean Cenas
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesCenas(
    List<String> ingredientesDisponibles,
  ) async {
    final List<Map<String, dynamic>> recetasDisponibles =
        await _database.rawQuery('''
    SELECT *
    FROM Recetas r
    WHERE r.clasificacion = 'Cena' AND EXISTS (
        SELECT *
        FROM Lista_Ingredientes li
        LEFT JOIN Ingredientes i ON li.id_ingrediente = i.id_ingrediente
        WHERE li.id_receta = r.id_receta AND (i.cantidad > 0)
        ) ORDER BY nombre_receta ASC
    ''');
    return recetasDisponibles;
  }

  // Método para obtener las recetas favoritas de desayuno
  Future<List<Receta>> obtenerRecetaFavoritasDesayuno() async {
    List<Map<String, dynamic>> recetasMap = await _database.rawQuery(
      'SELECT * FROM Recetas WHERE favoritos = 1 AND clasificacion = "Desayuno" ORDER BY nombre_receta ASC',
    );
    return recetasMap
        .map((e) => Receta(
            id: e['id_receta'],
            nombre: e['nombre_receta'],
            imagen: e['imagen_receta'],
            preparacion: e['Preparacion_receta'],
            favoritos: e['favoritos'],
            clasificacion: e['clasificacion'],
            informacion: e['info_nutricional']))
        .toList();
  }

  // Método para obtener las recetas favoritas de comida
  Future<List<Receta>> obtenerRecetaFavoritasComida() async {
    List<Map<String, dynamic>> recetasMap = await _database.rawQuery(
      'SELECT * FROM Recetas WHERE favoritos = 1 AND clasificacion = "Comida" ORDER BY nombre_receta ASC',
    );
    return recetasMap
        .map((e) => Receta(
            id: e['id_receta'],
            nombre: e['nombre_receta'],
            imagen: e['imagen_receta'],
            preparacion: e['Preparacion_receta'],
            favoritos: e['favoritos'],
            clasificacion: e['clasificacion'],
            informacion: e['info_nutricional']))
        .toList();
  }

  // Método para obtener las recetas favoritas de cena
  Future<List<Receta>> obtenerRecetaFavoritasCena() async {
    List<Map<String, dynamic>> recetasMap = await _database.rawQuery(
      'SELECT * FROM Recetas WHERE favoritos = 1 AND clasificacion = "Cena" ORDER BY nombre_receta ASC',
    );
    return recetasMap
        .map((e) => Receta(
            id: e['id_receta'],
            nombre: e['nombre_receta'],
            imagen: e['imagen_receta'],
            preparacion: e['Preparacion_receta'],
            favoritos: e['favoritos'],
            clasificacion: e['clasificacion'],
            informacion: e['info_nutricional']))
        .toList();
  }

  // Método para obtener la lista de informacion nutricional por preparación
  Future<String?> obtenerInfoNutriReceta(int idReceta) async {
    final result = await _database
        .query('Recetas', where: 'id_receta = ?', whereArgs: [idReceta]);
    if (result.isNotEmpty) {
      return result.first['info_nutricional'] as String?;
    }
    return null;
  }
}
