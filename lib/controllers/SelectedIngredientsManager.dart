import 'package:balanced_meal/models/ingredient_model.dart';

class SelectedIngredientsManager {
  static List<IngredientModel> _selectedIngredients = [];

  List<IngredientModel> get selectedIngredients => _selectedIngredients;

  int getIngredientQuantity(IngredientModel ingredient) {
    final existingIndex = _selectedIngredients.indexWhere(
      (item) => item.food_name == ingredient.food_name,
    );
    return existingIndex != -1
        ? _selectedIngredients[existingIndex].quantity
        : -1;
  }

  void addIngredient(IngredientModel ingredient) {
    final existingIndex = _selectedIngredients.indexWhere(
      (item) => item.food_name == ingredient.food_name,
    );

    if (existingIndex != -1) {
      _selectedIngredients[existingIndex].quantity++;
    } else {
      _selectedIngredients.add(
        IngredientModel(
          food_name: ingredient.food_name,
          calories: ingredient.calories,
          image_url: ingredient.image_url,
          quantity: 1,
        ),
      );
    }
  }

  void removeIngredient(IngredientModel ingredient) {
    final index = _selectedIngredients.indexWhere(
      (item) => item.food_name == ingredient.food_name,
    );

    if (index != -1) {
      if (_selectedIngredients[index].quantity > 1) {
        _selectedIngredients[index].quantity--;
      } else {
        _selectedIngredients.removeAt(index);
      }
    }
  }

  void clearSelectedIngredients() {
    _selectedIngredients.clear();
  }

  int get sumCalories {
    return _selectedIngredients.fold(
      0,
      (sum, item) => sum + (item.calories * item.quantity),
    );
  }

  double get totalPrice {
    return _selectedIngredients.fold(
      0.0,
      (sum, item) => sum + (item.quantity * 12),
    );
  }
}
