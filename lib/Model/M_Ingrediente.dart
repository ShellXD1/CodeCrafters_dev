import 'package:proyecto_tsp_dev/Model/DR_Ingrediente.dart';
import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';
import 'package:sqflite/sqflite.dart';

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
}
