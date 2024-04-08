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
        ingredient: 'Dientes de ajo, Pasta, Tomate, Cebolla',
        process: 'Rallar el diente de ajo en una casuela, poner la pasta a cocer a fuego medio hasta que hablande, retirarla de la estufa y remover toda el agua'),
    Recipe(
        name: 'Ensalada César',
        image: 'ensalada.png',
        ingredient: 'Tomatillo, Pollo, Lechuga',
        process: 'Cortar el tomatillo en cubos, cocinar la pechuga de pollo en pequeños cubos, cortar la lechuga en trosos de tamaño medio, cortar el pan en cubitos pequeños'),
    Recipe(
        name: 'huarache',
        image: 'huarache.png',
        ingredient: 'Tomate, Arina, Frijol, lechuga, cebolla',
        process: 'Cortar el tomate en rodajas, hacer los frijoles refritos, picar la lechuga, picar la cebolla, preparar la masa para hacer las chanclas'),
  ];

  List<Recipe> get recipes => _recipes;
}
