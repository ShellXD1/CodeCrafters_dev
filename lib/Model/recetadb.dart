class Receta {
  int id;
  String nombre;
  String imagen;
  String preparacion;

  Receta(
      {required this.id,
      required this.nombre,
      required this.imagen,
      required this.preparacion});

  // Método para convertir un objeto Receta a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id_receta': id,
      'nombre_receta': nombre,
      'imagen_receta': imagen,
      'Preparacion_receta': preparacion
    };
  }
}
