class Preparacion {
  int id;
  String pasos;
  int tiempo;

  Preparacion({required this.id, required this.pasos, required this.tiempo});

  // Método para convertir un objeto Receta a un mapa
  Map<String, dynamic> toMap() {
    return {'id_pre': id, 'pasos_pre': pasos, 'tiempo': tiempo};
  }
}
