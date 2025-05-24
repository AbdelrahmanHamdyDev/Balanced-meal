import 'package:balanced_meal/controllers/SelectedIngredientsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderBottomSheet extends StatelessWidget {
  OrderBottomSheet({
    super.key,
    required this.userTotalCalories,
    required this.onPressed,
    required this.buttonText,
    this.isVisible = true,
  });

  final SelectedIngredientsManager selectedIngredients =
      SelectedIngredientsManager();
  final int userTotalCalories;
  final Function() onPressed;
  final String buttonText;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    final isButtonEnabled =
        selectedIngredients.sumCalories >= (userTotalCalories * 0.9).round();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      height: 170.h,
      child: Padding(
        padding: EdgeInsets.only(top: 16.h, right: 24.w, left: 24.w),
        child: Column(
          spacing: 10.h,
          children: [
            Row(
              children: [
                Text("Cal", style: Theme.of(context).textTheme.bodyLarge),
                const Spacer(),
                Text(
                  "${selectedIngredients.sumCalories} Cal out of $userTotalCalories Cal",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              children: [
                Text("Price", style: Theme.of(context).textTheme.bodyLarge),
                const Spacer(),
                Text(
                  "\$${selectedIngredients.totalPrice}",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isButtonEnabled ? onPressed : null,
                child: Text(buttonText),
                style: Theme.of(context).elevatedButtonTheme.style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
