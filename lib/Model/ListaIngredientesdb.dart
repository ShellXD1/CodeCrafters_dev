class ListIng {
  int idList;
  int idIng;
  int cantidad;

  ListIng({required this.idList, required this.idIng, required this.cantidad});

  // Método para convertir un objeto Receta a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id_lis_ing': idList,
      'id_ing': idIng,
      'cantidad_lis_ing': cantidad
    };
  }
}
