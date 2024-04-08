import 'package:proyecto_tsp_dev/Model/DR_Receta.dart';
import 'package:proyecto_tsp_dev/Model/recetadb.dart';
import 'package:sqflite/sqflite.dart';

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
}
