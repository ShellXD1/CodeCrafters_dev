import 'package:proyecto_tsp_dev/Model/DR_Ingrediente.dart';
import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;
import 'package:sqflite_common/sqlite_api.dart';

class MIngrediente {
  final DRIngrediente _repository;

  MIngrediente(Database database) : _repository = DRIngrediente(database);

  // Método para obtener la lista de ingredientes
  Future<List<Ingrediente>> obtenerIngredientes() async {
    return _repository.getIngredientes();
  }

  // Método para obtener la lista de ingredientes para una receta específica
  Future<List<Ingrediente>> obtenerIngredientesPorReceta(int idReceta) async {
    return _repository.getIngredientesPorReceta(idReceta);
  }

  // Método para agregar la cantidad de un ingrediente
  Future<void> agregarCantidadIngrediente(
      int idIngrediente, int cantidad) async {
    await _repository.agregarCantidadIngrediente(idIngrediente, cantidad);
  }

  // Método para quitar la cantidad de un ingrediente
  Future<void> quitarCantidadIngrediente(
      int idIngrediente, int cantidad) async {
    await _repository.quitarCantidadIngrediente(idIngrediente, cantidad);
  }

  // Método para obtener la lista de ingredientes por preparación
  Future<List<Ingrediente>> obtenerIngredientesPorPreparacion(
      int idPreparacion) async {
    return await _repository.obtenerIngredientesPorPreparacion(idPreparacion);
  }
}
