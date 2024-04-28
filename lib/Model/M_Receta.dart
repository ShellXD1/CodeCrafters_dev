import 'package:proyecto_tsp_dev/Model/DR_Receta.dart';
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
  Future<List<Map<String, dynamic>>> getRecetasDisponibles(List<String> ingredientesDisponibles) async {
    return await _repository.getRecetasDisponibles(ingredientesDisponibles);
  }
}
