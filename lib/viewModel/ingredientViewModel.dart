import 'package:flutter/material.dart';

class Ingredient {
  final String name;
  final int quantity;

  Ingredient({required this.name, required this.quantity});
}

class IngredientViewModel extends ChangeNotifier {
  List<Ingredient> _ingredient = [
    Ingredient(name: 'Jitomate', quantity: 3),
    Ingredient(name: 'Dientes de ajo', quantity: 3),
    Ingredient(name: 'Cebolla', quantity: 3),
    Ingredient(name: 'Cebollin', quantity: 7),
    Ingredient(name: 'Jalapeño', quantity: 1),
    Ingredient(name: 'Tomatillo', quantity: 1),
  ];

  List<Ingredient> get ingredient => _ingredient;
}

