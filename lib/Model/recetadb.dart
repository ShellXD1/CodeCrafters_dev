class Receta {
  int id;
  String nombre;
  String imagen;
  String preparacion;
  int favoritos;

  Receta(
      {required this.id,
      required this.nombre,
      required this.imagen,
      required this.preparacion,
      required this.favoritos});

  get ingredientes => null;

  // Método para convertir un objeto Receta a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id_receta': id,
      'nombre_receta': nombre,
      'imagen_receta': imagen,
      'Preparacion_receta': preparacion,
      'favoritos' : favoritos
    };
  }
}
