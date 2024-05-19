import 'package:proyecto_tsp_dev/Model/DR_Receta.dart';
import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';
import 'package:proyecto_tsp_dev/Model/recetadb.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;
import 'package:sqflite_common/sqlite_api.dart';

class MReceta {
  final DRReceta _repository;

  MReceta(Database database) : _repository = DRReceta(database);

  // Método para obtener la lista de recetas
  Future<List<Receta>> obtenerRecetas() async {
    return _repository.getRecetas();
  }

   // Método para obtener la lista de recetas
  Future<List<Receta>> obtenerRecetasClasificacion(String clasificacion) async {
    return _repository.getRecetasPorClasificacion(clasificacion);
  }

  // Método para agregar una nueva receta
  Future<void> agregarReceta(Receta receta) async {
    await _repository.addReceta(receta);
  }

  // Método para obtrner nombre de receta
  Future<String?> obtenerNombreRecetaPorId(int idReceta) async {
    return await _repository.obtenerNombreReceta(idReceta);
  }

  // Método para obtener imagen de receta
  Future<String?> obtenerImagenRecetaPorId(int idReceta) async {
    return await _repository.obtenerImagenReceta(idReceta);
  }

  // Método para obtener las recetas disponibles a partir de los ingredientes disponibles
  Future<List<Map<String, dynamic>>> getRecetasDisponibles(
      List<String> ingredientesDisponibles) async {
    // Llama al método correspondiente en el repositorio
    return await _repository.getRecetasDisponibles(ingredientesDisponibles);
  }

  // Método para marcar una receta como favorita
  Future<void> marcarRecetaComoFavorita(int idReceta) async {
    await _repository.marcarRecetaComoFavorita(idReceta);
  }

  // Método para eliminar una receta de favoritos
  Future<void> eliminarRecetaDeFavoritos(int idReceta) async {
    await _repository.eliminarRecetaDeFavoritos(idReceta);
  }

  // Método para verificar si una receta es favorita
  Future<bool> esRecetaFavorita(int idReceta) async {
    return await _repository.esRecetaFavorita(idReceta);
  }

  // Método para obtener las recetas favoritas
  Future<List<Receta>> obtenerRecetaFavoritas() async {
    return await _repository.obtenerRecetaFavoritas();
  }

  // Método para obtener las recetas disponibles a partir de los ingredientes disponibles Y si son Desayunos
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesDesayunos(
      List<String> ingredientesDisponibles) async {
    // Llama al método correspondiente en el repositorio
    return await _repository.getRecetasDisponiblesDesayunos(ingredientesDisponibles);
  }

  // Método para obtener las recetas disponibles a partir de los ingredientes disponibles Y si son Comidas
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesComidas(
      List<String> ingredientesDisponibles) async {
    // Llama al método correspondiente en el repositorio
    return await _repository.getRecetasDisponiblesComidas(ingredientesDisponibles);
  }

  // Método para obtener las recetas disponibles a partir de los ingredientes disponibles Y si son Cenas
  Future<List<Map<String, dynamic>>> getRecetasDisponiblesCenas(
      List<String> ingredientesDisponibles) async {
    // Llama al método correspondiente en el repositorio
    return await _repository.getRecetasDisponiblesCenas(ingredientesDisponibles);
  }

  // Método para obtener las recetas favoritas
  Future<List<Receta>> obtenerRecetaFavoritasDesayuno() async {
    return await _repository.obtenerRecetaFavoritasDesayuno();
  }

  // Método para obtener las recetas favoritas
  Future<List<Receta>> obtenerRecetaFavoritasComida() async {
    return await _repository.obtenerRecetaFavoritasComida();
  }

  // Método para obtener las recetas favoritas
  Future<List<Receta>> obtenerRecetaFavoritasCena() async {
    return await _repository.obtenerRecetaFavoritasCena();
  }
  
}
