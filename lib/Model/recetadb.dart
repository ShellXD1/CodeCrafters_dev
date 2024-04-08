class Receta {
  int id;
  String nombre;
  String imagen;
  String descripcion;
  int idPreparacion;

  Receta(
      {required this.id,
      required this.nombre,
      required this.imagen,
      required this.descripcion,
      required this.idPreparacion});

  // Método para convertir un objeto Receta a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id_receta': id,
      'nombre_receta': nombre,
      'imagen_receta': imagen,
      'descripcion_receta': descripcion,
      'id_pre': idPreparacion,
    };
  }
}
