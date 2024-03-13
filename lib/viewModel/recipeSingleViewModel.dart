import 'package:flutter/material.dart';

class RecipeSingle {
  final String name;
  final String image;
  final String ingredient;
  final String process;

  RecipeSingle(
      {required this.name,
      required this.image,
      required this.ingredient,
      required this.process});
}

class RecipeSingleViewModel extends ChangeNotifier {
  List<RecipeSingle> _recipeSingles = [
    RecipeSingle(
        name: 'Spaghetti Carbonara',
        image: 'spaghetti.png',
        ingredient: 'Dientes de ajo',
        process: 'Rayar el diente de ajo en una casuela'),
    RecipeSingle(
        name: 'Ensalada César',
        image: 'ensalada.png',
        ingredient: 'Tomatillo',
        process: 'Cortar el tomatillo en cubos'),
    RecipeSingle(
        name: 'huarache',
        image: 'huarache.png',
        ingredient: 'Tomate',
        process: 'Cortar el tomate en rodajas'),
  ];

  List<RecipeSingle> get recipeSingles => _recipeSingles;
}
