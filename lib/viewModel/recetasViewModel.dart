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

   // Método para obtener los ingredientes por preparación
  Future<List<Ingrediente>> obtenerIngredientesPorPreparacion(int idPreparacion) async {
    // Aquí deberías realizar la consulta a la base de datos o a tu modelo para obtener los ingredientes por la preparación con el id proporcionado
    // Supongamos que la consulta devuelve una lista de ingredientes como List<String>
    List<Ingrediente> ingredientes = await _mRecetas.obtenerIngredientesPorPreparacion(idPreparacion);
    return ingredientes;
  }
}
