import 'package:proyecto_tsp_dev/Model/DR_Preparacion.dart';
import 'package:proyecto_tsp_dev/Model/preparaciondb.dart';
import 'package:sqflite/sqflite.dart';

class MPreparacion {
  final DRPreparacion _repository;

  MPreparacion(Database database) : _repository = DRPreparacion(database);

  // Obtener preparación
  Future<List<Preparacion>> getPreparacion() async {
    return _repository.getPreparacion();
  }
}
