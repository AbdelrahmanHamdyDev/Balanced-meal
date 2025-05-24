class IngredientModel {
  IngredientModel({
    required this.food_name,
    required this.calories,
    required this.image_url,
    this.quantity = 0,
  });

  final String food_name;
  final int calories;
  final String image_url;
  int quantity;

  Map<String, dynamic> toOrderItem() => {
    'name': food_name,
    'total_price': 12 * quantity,
    'quantity': quantity,
  };
}
