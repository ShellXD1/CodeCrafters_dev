import 'package:flutter/material.dart';

// Clase para mostrar el botón de favoritos
class BotonFavoritos extends StatelessWidget {
  final bool esFavorita;
  final VoidCallback onPressed;

  // Constructor
  const BotonFavoritos({
    Key? key,
    required this.esFavorita,
    required this.onPressed,
  }) : super(key: key);

  // Cuerpo del botón
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: esFavorita ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
      onPressed: onPressed,
    );
  }
}
