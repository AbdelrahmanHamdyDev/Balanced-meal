import 'dart:convert';
import 'package:balanced_meal/models/ingredient_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static Future<bool> placeOrder(List<IngredientModel> selected) async {
    final url = Uri.parse(dotenv.env['API_BASE_URL']!);
    final response = await http.post(
      url,
      body: jsonEncode({
        'items': selected.map((item) => item.toOrderItem()).toList(),
      }),
    );
    return response.statusCode == 200 && response.body.contains('true');
  }
}
