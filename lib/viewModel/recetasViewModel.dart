import 'package:flutter/material.dart';
import 'package:proyecto_tsp_dev/Model/M_Receta.dart';
import 'package:proyecto_tsp_dev/Model/ingredientedb.dart';
import 'package:proyecto_tsp_dev/Model/recetadb.dart';

class RecetasViewModel extends ChangeNotifier {
  final MReceta _mRecetas;

  RecetasViewModel(this._mRecetas);

  List<Receta> _recetas = [];
  List<Receta> get recetas => _recetas;

  List<Ingrediente> _ingredientes = [];
  List<Ingrediente> get ingredientes => _ingredientes;

  // Método para obtener las recetas
  Future<void> obtenerRecetas() async {
    _recetas = await _mRecetas.obtenerRecetas();
    notifyListeners();
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
}
