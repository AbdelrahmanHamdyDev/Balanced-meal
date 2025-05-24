import 'package:balanced_meal/controllers/SelectedIngredientsManager.dart';
import 'package:balanced_meal/views/welcome_screen.dart';
import 'package:balanced_meal/views/widgets/appBar.dart';
import 'package:balanced_meal/views/widgets/ingredients/OrderBottomSheet.dart';
import 'package:balanced_meal/views/widgets/ingredients/ingredient_cart_card.dart';
import 'package:balanced_meal/controllers/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class orderSummary_Screen extends StatefulWidget {
  orderSummary_Screen({
    super.key,
    required this.userTotalCalories,
    required this.onIngredientsUpdated,
  });

  final SelectedIngredientsManager selectedIngredients =
      SelectedIngredientsManager();
  final int userTotalCalories;
  final Function() onIngredientsUpdated;

  @override
  State<orderSummary_Screen> createState() => _orderSummary_ScreenState();
}

class _orderSummary_ScreenState extends State<orderSummary_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const appBar_Widget(title: "Order Summary"),
      body: PopScope(
        onPopInvokedWithResult:
            (didPop, result) => widget.onIngredientsUpdated(),
        child: Padding(
          padding: EdgeInsets.only(bottom: 170.h),
          child: ListView.builder(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 38.h),
            itemCount: widget.selectedIngredients.selectedIngredients.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: ingredientCart_Card(
                  selectedIngredient:
                      widget.selectedIngredients.selectedIngredients[index],
                  onIngredientsUpdated: () {
                    setState(() {});
                  },
                ),
              );
            },
          ),
        ),
      ),

      bottomSheet: OrderBottomSheet(
        userTotalCalories: widget.userTotalCalories,
        buttonText: "Confirm",
        onPressed: () async {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Waiting to review order")),
          );
          bool result = await ApiService.placeOrder(
            widget.selectedIngredients.selectedIngredients,
          );
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (result) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Order confirmed")));
            //clear the selected list
            widget.selectedIngredients.clearSelectedIngredients();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const welcomeScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Error Cause, Please Try Again Later"),
              ),
            );
          }
        },
      ),
    );
  }
}
