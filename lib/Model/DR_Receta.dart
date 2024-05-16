import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:proyecto_tsp_dev/Model/recetadb.dart';

class DRReceta {
  final Database _database;

  DRReceta(this._database);

  // Obtener la lista de recetas
  Future<List<Receta>> getRecetas() async {
    List<Map<String, dynamic>> tables = await _database
        .rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    print("Tablas en la base de datos: $tables");
    List<Map<String, dynamic>> recetasMap = await _database.query('Recetas');
    return recetasMap
        .map((e) => Receta(
            id: e['id_receta'],
            nombre: e['nombre_receta'],
            imagen: e['imagen_receta'],
            preparacion: e['Preparacion_receta'],
            favoritos: e['favoritos'], 
            clasificacion: e['clasificacion'], 
            ingredientes: e['ingredientes'], 
            informacion: e['info_nutricional']))
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

  // Obtener recetas disponibles a partir de los ingredientes disponibles
  Future<List<Map<String, dynamic>>> getRecetasDisponibles(
    List<String> ingredientesDisponibles,
  ) async {
    final List<Map<String, dynamic>> recetasDisponibles =
        await _database.rawQuery('''
    SELECT r.id_receta, r.nombre_receta, r.imagen_receta
    FROM Recetas r
    WHERE NOT EXISTS (
        SELECT *
        FROM Lista_Ingredientes li
        LEFT JOIN Ingredientes i ON li.id_ingrediente = i.id_ingrediente
        WHERE li.id_receta = r.id_receta AND (i.id_ingrediente IS NULL OR li.cantidad_ingrediente > i.cantidad)
        );
    ''');
    print(
        'Entre AQUI WEEEEE AQUI WEEEE Recetas disponibles: $recetasDisponibles');
    return recetasDisponibles;
  }

  // Método para obtener la lista de ingredientes por preparación
  Future<List<Ingrediente>> obtenerIngredientesPorPreparacion(
      int idPreparacion) async {
    final List<Map<String, dynamic>> ingredientesPorPreparacion =
        await _database.rawQuery('''
      SELECT Ingredientes.id_ingrediente, Ingredientes.nombre_ing, Ingredientes.Cantidad
      FROM Ingredientes
      INNER JOIN Lista_ingredientes ON Ingredientes.id_ingrediente = Lista_ingredientes.id_ingrediente
      WHERE Lista_ingredientes.id_receta = ?
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

  // Método para obtener las recetas favoritas
  Future<List<Receta>> obtenerRecetaFavoritas() async {
    List<Map<String, dynamic>> recetasMap = await _database.rawQuery(
      'SELECT * FROM Recetas WHERE favoritos = 1',
    );
    return recetasMap
        .map((e) => Receta(
              id: e['id_receta'],
              nombre: e['nombre_receta'],
              imagen: e['imagen_receta'],
              preparacion: e['Preparacion_receta'],
              favoritos: e['favoritos'],
              clasificacion: e['clasificacion'], 
              ingredientes: e['ingredientes'], 
              informacion: e['info_nutricional']
            ))
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
    print('Consultando si la receta es favorita...');

    // Realizar la consulta a la base de datos para obtener el valor de 'favoritos'
    final result = await _database.query(
      'Recetas',
      columns: ['favoritos'],
      where: 'id_receta = ?',
      whereArgs: [idReceta],
    );

    print('Resultado de la consulta: $result');

    // Verificar si se encontró un registro para la receta
    if (result.isNotEmpty) {
      // Obtener el valor de 'favoritos' del primer registro
      final favoritos = result.first['favoritos'] as int?;
      print('Valor de favoritos: $favoritos');
      // Verificar si el valor de 'favoritos' es 1 (favorita)
      if (favoritos != null && favoritos == 1) {
        print('La receta es favorita.');
        return true;
      }
    }

    print('La receta no es favorita.');
    // Si no se encontró un registro o 'favoritos' es distinto de 1, se asume que no es favorita
    return false;
  }


  // Obtener recetas disponibles a partir de los ingredientes disponibles y que sean Desayunos
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesDesayunos(
    List<String> ingredientesDisponibles,
  ) async {
    final List<Map<String, dynamic>> recetasDisponibles =
        await _database.rawQuery('''
    SELECT r.id_receta, r.nombre_receta, r.imagen_receta
    FROM Recetas r
    WHERE r.clasificacion = 'Desayuno' AND NOT EXISTS (
        SELECT *
        FROM Lista_Ingredientes li
        LEFT JOIN Ingredientes i ON li.id_ingrediente = i.id_ingrediente
        WHERE li.id_receta = r.id_receta AND (i.id_ingrediente IS NULL OR li.cantidad_ingrediente > i.cantidad)
        );
    ''');
    print('Entre AQUI WEEEEE AQUI WEEEE Recetas disponibles: $recetasDisponibles');
    return recetasDisponibles;
  }

  // Obtener recetas disponibles a partir de los ingredientes disponibles y que sean Comidas
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesComidas(
    List<String> ingredientesDisponibles,
  ) async {
    final List<Map<String, dynamic>> recetasDisponibles =
        await _database.rawQuery('''
    SELECT r.id_receta, r.nombre_receta, r.imagen_receta
    FROM Recetas r
    WHERE r.clasificacion = 'Comida' AND NOT EXISTS (
        SELECT *
        FROM Lista_Ingredientes li
        LEFT JOIN Ingredientes i ON li.id_ingrediente = i.id_ingrediente
        WHERE li.id_receta = r.id_receta AND (i.id_ingrediente IS NULL OR li.cantidad_ingrediente > i.cantidad)
        );
    ''');
    print('Entre AQUI WEEEEE AQUI WEEEE Recetas disponibles: $recetasDisponibles');
    return recetasDisponibles;
  }

  // Obtener recetas disponibles a partir de los ingredientes disponibles y que sean Cenas
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesCenas(
    List<String> ingredientesDisponibles,
  ) async {
    final List<Map<String, dynamic>> recetasDisponibles =
        await _database.rawQuery('''
    SELECT r.id_receta, r.nombre_receta, r.imagen_receta
    FROM Recetas r
    WHERE r.clasificacion = 'Cena' AND NOT EXISTS (
        SELECT *
        FROM Lista_Ingredientes li
        LEFT JOIN Ingredientes i ON li.id_ingrediente = i.id_ingrediente
        WHERE li.id_receta = r.id_receta AND (i.id_ingrediente IS NULL OR li.cantidad_ingrediente > i.cantidad)
        );
    ''');
    print('Entre AQUI WEEEEE AQUI WEEEE Recetas disponibles: $recetasDisponibles');
    return recetasDisponibles;
  }
}
