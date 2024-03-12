import 'package:flutter/material.dart';

class Recipe {
  final String name;
  final String image;

  Recipe({required this.name, required this.image});
}

class RecipeViewModel extends ChangeNotifier {
  List<Recipe> _recipes = [
    Recipe(name: 'Spaghetti Carbonara', image: 'spaghetti.png'),
    Recipe(name: 'Ensalada César', image: 'ensalada.png'),
    Recipe(name: 'huarache', image: 'huarache.png'),
  ];

  List<Recipe> get recipes => _recipes;
}
