import 'package:flutter/material.dart';

class Recipe {
  final String name;
  final String image;

  Recipe({required this.name, required this.image});
}

class RecipeViewModel extends ChangeNotifier {
  List<Recipe> _recipes = [
    Recipe(name: 'Spaghetti Carbonara', image: 'spaghetti_carbonara.jpg'),
    Recipe(name: 'Ensalada César', image: 'ensalada_cesar.jpg'),
    // Puedes agregar más recetas aquí
  ];

  List<Recipe> get recipes => _recipes;
}