import 'package:flutter/material.dart';

class Recipe {
  final String name;
  final String image;
  final String ingredient;
  final String process;

  Recipe(
      {required this.name,
      required this.image,
      required this.ingredient,
      required this.process});
}

class RecipeViewModel extends ChangeNotifier {
  List<Recipe> _recipes = [
    Recipe(
        name: 'Spaghetti Carbonara',
        image: 'spaghetti.png',
        ingredient: 'Dientes de ajo',
        process: 'Rayar el diente de ajo en una casuela'),
    Recipe(
        name: 'Ensalada César',
        image: 'ensalada.png',
        ingredient: 'Tomatillo',
        process: 'Cortar el tomatillo en cubos'),
    Recipe(
        name: 'huarache',
        image: 'huarache.png',
        ingredient: 'Tomate',
        process: 'Cortar el tomate en rodajas'),
  ];

  List<Recipe> get recipes => _recipes;
}
