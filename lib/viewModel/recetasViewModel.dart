import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/Model/M_Receta.dart';
import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';
import 'package:proyecto_tsp_dev/Model/recetadb.dart';

class RecetasViewModel extends ChangeNotifier {
  final MReceta _mRecetas;

  RecetasViewModel(this._mRecetas);

  List<Receta> _recetas = [];
  List<Receta> get recetas => _recetas;

  bool _recetasCargadas =
      false; // Variable para rastrear si las recetas se han cargado
  bool get recetasCargadas => _recetasCargadas;

  // Método para obtener las recetas
  Future<void> obtenerRecetas() async {
    _recetas = await _mRecetas.obtenerRecetas();
    _recetasCargadas = true; // Marcar las recetas como cargadas
    notifyListeners(); // Notificar a los oyentes del cambio en el estado
  }

  // Método para obtener el nombre y la imagen de una receta por su ID
  Future<Map<String, String?>> obtenerNombreEImagenReceta(int idReceta) async {
    final nombre = await _mRecetas.obtenerNombreRecetaPorId(idReceta);
    final imagen = await _mRecetas.obtenerImagenRecetaPorId(idReceta);
    return {'nombre': nombre, 'imagen': imagen};
  }

  // Método para obtener el nombre por su ID
  Future<Map<String, String?>> obtenerNombreReceta(int idReceta) async {
    final nombre = await _mRecetas.obtenerNombreRecetaPorId(idReceta);
    return {'nombre': nombre};
  }

  // Método para obtener el nombre y la imagen de una receta por su ID
  Future<Map<String, String?>> obtenerImagenReceta(int idReceta) async {
    final imagen = await _mRecetas.obtenerImagenRecetaPorId(idReceta);
    return {'imagen': imagen};
  }

  // Función para obtener las recetas disponibles a partir de los ingredientes disponibles
  Future<List<Map<String, dynamic>>> getRecetasDisponibles(
      List<String> ingredientesDisponibles) async {
    return await _mRecetas.getRecetasDisponibles(ingredientesDisponibles);
  }

  Future<Map<String, dynamic>?> getRecipeDetails(int recipeIndex) async {
    // Verificar si el índice es válido
    if (recipeIndex < 0 || recipeIndex >= recetas.length) {
      return null;
    }

    // Obtener la receta correspondiente al índice
    Receta receta = recetas[recipeIndex];

    // Construir un mapa con los detalles de la receta
    Map<String, dynamic> recipeDetails = {
      'imagen': receta.imagen, // URL de la imagen de la receta
      'ingredientes': receta.ingredientes,
      'preparacion': receta.preparacion,
    };

    // Simular un retraso de 1 segundo para imitar una llamada asíncrona a una API o base de datos
    await Future.delayed(Duration(seconds: 1));

    // Devolver los detalles de la receta
    return recipeDetails;
  }

  // Métodos para marcar una receta como favorita
  Future<void> marcarRecetaComoFavorita(int idReceta) async {
    await _mRecetas.marcarRecetaComoFavorita(idReceta);
    notifyListeners();
  }

  // Método para eliminar una receta de favoritos
  Future<void> eliminarRecetaDeFavoritos(int idReceta) async {
    await _mRecetas.eliminarRecetaDeFavoritos(idReceta);
    notifyListeners();
  }

  // Método para verificar si una receta es favorita
  Future<bool> esRecetaFavorita(int idReceta) async {
    return await _mRecetas.esRecetaFavorita(idReceta);
  }

  // Método para obtener las recetas favoritas
  Future<void> obtenerRecetasFavoritas() async {
    List<Receta> recetasFavoritas = await _mRecetas.obtenerRecetaFavoritas();
    // Actualizar la lista de recetas favoritas en el ViewModel
    _recetas = recetasFavoritas;
    notifyListeners(); // Notificar a los oyentes del cambio en el estado
  }

  // Método para alternar el estado de favorito de una receta
  Future<void> toggleFavorita(int recetaId) async {
    // Verificar si la receta ya es favorita
    final bool esFavorita = await esRecetaFavorita(recetaId);

    // Si es favorita, eliminarla de favoritos; de lo contrario, marcarla como favorita
    if (esFavorita) {
      await eliminarRecetaDeFavoritos(recetaId);
    } else {
      await marcarRecetaComoFavorita(recetaId);
    }
    notifyListeners(); // Notificar a los oyentes del cambio en el estado
  }

  // Método dinamico para obtener las recetas favoritas
  Future<List<Map<String, dynamic>>> getRecetasFavoritas() async {
    List<Receta> recetasFavoritas = await _mRecetas.obtenerRecetaFavoritas();
    // Mapear las recetas favoritas a un formato de lista de mapas
    List<Map<String, dynamic>> recetasFavoritasMap =
        recetasFavoritas.map((receta) {
      return {
        'id_receta': receta.id,
        'nombre_receta': receta.nombre,
        'imagen_receta': receta.imagen,
        // Añade otros campos de la receta según sea necesario
      };
    }).toList();
    return recetasFavoritasMap;
  }

  // Método dinamico para obtener todas las recetas
  Future<List<Map<String, dynamic>>> getRecetas() async {
    List<Receta> recetas = await _mRecetas.obtenerRecetas();
    // Mapear las recetas a un formato de lista de mapas
    List<Map<String, dynamic>> recetasMap = recetas.map((receta) {
      return {
        'id_receta': receta.id,
        'nombre_receta': receta.nombre,
        'imagen_receta': receta.imagen,
        // Añade otros campos de la receta según sea necesario
      };
    }).toList();
    return recetasMap;
  }

  // Función para obtener las recetas disponibles a partir de los ingredientes disponibles y son Desayunos
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesDesayunos(
      List<String> ingredientesDisponibles) async {
    return await _mRecetas.getRecetasDisponiblesDesayunos(ingredientesDisponibles);
  }
  // Función para obtener las recetas disponibles a partir de los ingredientes disponibles y son Comidas
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesComidas(
      List<String> ingredientesDisponibles) async {
    return await _mRecetas.getRecetasDisponiblesComidas(ingredientesDisponibles);
  }

  // Función para obtener las recetas disponibles a partir de los ingredientes disponibles y son Cenas
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesCenas(
      List<String> ingredientesDisponibles) async {
    return await _mRecetas.getRecetasDisponiblesCenas(ingredientesDisponibles);
  }

  // Método dinamico para obtener las recetas favoritas de desayuno
  Future<List<Map<String, dynamic>>> obtenerRecetasFavoritasDesayuno() async {
    List<Receta> recetasFavoritas = await _mRecetas.obtenerRecetaFavoritasDesayuno();
    // Mapear las recetas favoritas a un formato de lista de mapas
    List<Map<String, dynamic>> recetasFavoritasMap =
        recetasFavoritas.map((receta) {
      return {
        'id_receta': receta.id,
        'nombre_receta': receta.nombre,
        'imagen_receta': receta.imagen,
        // Añade otros campos de la receta según sea necesario
      };
    }).toList();
    return recetasFavoritasMap;
  }

  // Método dinamico para obtener las recetas favoritas de comida
  Future<List<Map<String, dynamic>>> obtenerRecetasFavoritasComida() async {
    List<Receta> recetasFavoritas = await _mRecetas.obtenerRecetaFavoritasComida();
    // Mapear las recetas favoritas a un formato de lista de mapas
    List<Map<String, dynamic>> recetasFavoritasMap =
        recetasFavoritas.map((receta) {
      return {
        'id_receta': receta.id,
        'nombre_receta': receta.nombre,
        'imagen_receta': receta.imagen,
        // Añade otros campos de la receta según sea necesario
      };
    }).toList();
    return recetasFavoritasMap;
  }

  // Método dinamico para obtener las recetas favoritas
  Future<List<Map<String, dynamic>>> obtenerRecetasFavoritasCena() async {
    List<Receta> recetasFavoritas = await _mRecetas.obtenerRecetaFavoritasCena();
    // Mapear las recetas favoritas a un formato de lista de mapas
    List<Map<String, dynamic>> recetasFavoritasMap =
        recetasFavoritas.map((receta) {
      return {
        'id_receta': receta.id,
        'nombre_receta': receta.nombre,
        'imagen_receta': receta.imagen,
        // Añade otros campos de la receta según sea necesario
      };
    }).toList();
    return recetasFavoritasMap;
  }

}
