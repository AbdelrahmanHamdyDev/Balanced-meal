import 'package:balanced_meal/models/ingredient_model.dart';
import 'package:balanced_meal/views/widgets/ingredients/ingredient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ingredientList_Widget extends StatelessWidget {
  const ingredientList_Widget({
    super.key,
    required this.title,
    required this.dummyData,
    required this.onIngredientsUpdated,
  });

  final String title;
  final List<IngredientModel> dummyData;
  final Function() onIngredientsUpdated;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: const Color(0xFF1E1E1E),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 768.w,
          height: 220.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dummyData.length,
            itemBuilder:
                (context, index) => Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: ingredientCard(
                    ingredient: dummyData[index],
                    onIngredientsUpdated: onIngredientsUpdated,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
