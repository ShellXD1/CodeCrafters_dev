class Ingrediente {
  int id;
  String nombre;
  String imagen;
  int cantidad;

  Ingrediente(
      {required this.id,
      required this.nombre,
      required this.imagen,
      required this.cantidad});

  // Método para convertir un objeto Receta a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id_ing': id,
      'nombre_ing': nombre,
      'imagen_ing': imagen,
      'cantidad': cantidad,
    };
  }
}
