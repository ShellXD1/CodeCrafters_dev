class Receta {
  int id;
  String nombre;
  String imagen;
  String preparacion;
  int favoritos;
  String clasificacion;
  String ingredientes;
  String infonutricional;

  Receta(
      {required this.id,
      required this.nombre,
      required this.imagen,
      required this.preparacion,
      required this.favoritos,
      required this.clasificacion,
      required this.ingredientes,
      required this.infonutricional});

  

  // Método para convertir un objeto Receta a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id_receta': id,
      'nombre_receta': nombre,
      'imagen_receta': imagen,
      'Preparacion_receta': preparacion,
      'favoritos' : favoritos,
      'clasificacion' : clasificacion,
      'ingredientes' : ingredientes,
      'info_nutricional' : infonutricional

    };
  }
}
