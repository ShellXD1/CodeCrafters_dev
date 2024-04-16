class ListIng {
  int idList;
  int cantidad;
  int idIng;
  int idreceta;

  ListIng(
      {required this.idList,
      required this.cantidad,
      required this.idIng,
      required this.idreceta});

  // Método para convertir un objeto Receta a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id_lis_ing': idList,
      'cantidad_lis_ing': cantidad,
      'id_ing': idIng,
      'id_recetas': idreceta
    };
  }
}
