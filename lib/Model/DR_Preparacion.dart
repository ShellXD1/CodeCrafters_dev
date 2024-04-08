import 'package:sqflite/sqflite.dart';
import 'package:proyecto_tsp_dev/Model/preparaciondb.dart';

class DRPreparacion {
  final Database _database;

  DRPreparacion(this._database);

  // Obtener lista preparacion
  Future<List<Preparacion>> getPreparacion() async {
    List<Map<String, dynamic>> preparacionMap =
        await _database.query('Ingredientes');
    return preparacionMap
        .map((e) => Preparacion(
            id: e['id_pre'], pasos: e['pasos_pre'], tiempo: e['tiempo']))
        .toList();
  }
}
