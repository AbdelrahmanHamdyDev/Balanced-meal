import 'package:balanced_meal/controllers/SelectedIngredientsManager.dart';
import 'package:balanced_meal/models/ingredient_model.dart';
import 'package:balanced_meal/views/order/order_summary_screen.dart';
import 'package:balanced_meal/views/widgets/appBar.dart';
import 'package:balanced_meal/views/widgets/ingredients/ingredient_list_view.dart';
import 'package:balanced_meal/controllers/firestore_controller.dart';
import 'package:balanced_meal/views/widgets/ingredients/OrderBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class placeOrder_screen extends StatefulWidget {
  const placeOrder_screen({super.key, required this.userTotalCalories});

  final int userTotalCalories;

  @override
  State<placeOrder_screen> createState() => _placeOrderState();
}

class _placeOrderState extends State<placeOrder_screen> {
  SelectedIngredientsManager selectedIngredients = SelectedIngredientsManager();
  final FirestoreService _firestoreService = FirestoreService();

  late List<IngredientModel> Vegetables = [];
  late List<IngredientModel> Meats = [];
  late List<IngredientModel> Carbs = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchIngredients();
  }

  Future<void> _fetchIngredients() async {
    try {
      // Fetch all categories in parallel
      final results = await Future.wait([
        _firestoreService.getVegetables(),
        _firestoreService.getMeats(),
        _firestoreService.getCarbs(),
      ]);

      setState(() {
        Vegetables = results[0];
        Meats = results[1];
        Carbs = results[2];
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading ingredients: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          (isLoading) ? null : const appBar_Widget(title: "Create Your order"),
      body: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: isLoading ? 0 : 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 24.h,
                  children: [
                    //Vegetables
                    ingredientList_Widget(
                      title: "Vegetables",
                      dummyData: Vegetables,
                      onIngredientsUpdated: () {
                        setState(() {});
                      },
                    ),
                    //Meats
                    ingredientList_Widget(
                      title: "Meats",
                      dummyData: Meats,
                      onIngredientsUpdated: () {
                        setState(() {});
                      },
                    ),
                    //Carbs
                    ingredientList_Widget(
                      title: "Carbs",
                      dummyData: Carbs,
                      onIngredientsUpdated: () {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 135.h),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                child: Lottie.asset('assets/Loading.json'),
              ),
            ),
        ],
      ),
      bottomSheet: OrderBottomSheet(
        userTotalCalories: widget.userTotalCalories,
        buttonText: "Place Order",
        isVisible: !isLoading,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => orderSummary_Screen(
                    userTotalCalories: widget.userTotalCalories,
                    onIngredientsUpdated: () => setState(() {}),
                  ),
            ),
          );
        },
      ),
    );
  }
}
