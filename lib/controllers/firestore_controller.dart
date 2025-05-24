import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balanced_meal/models/ingredient_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Generic method to fetch any ingredient collection
  Future<List<IngredientModel>> getIngredients(String collectionName) async {
    try {
      final snapshot = await _firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return IngredientModel(
          food_name: data['food_name'] ?? 'Unknown',
          calories: data['calories'] ?? 0,
          image_url: data['image_url'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error getting $collectionName: $e');
      return [];
    }
  }

  Future<List<IngredientModel>> getMeats() => getIngredients('Meats');
  Future<List<IngredientModel>> getCarbs() => getIngredients('Carbs');
  Future<List<IngredientModel>> getVegetables() => getIngredients('Vegetables');
}
