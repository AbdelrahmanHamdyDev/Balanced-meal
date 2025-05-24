import 'package:balanced_meal/controllers/SelectedIngredientsManager.dart';
import 'package:balanced_meal/models/ingredient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redacted/redacted.dart';

class ingredientCart_Card extends StatefulWidget {
  ingredientCart_Card({
    super.key,
    required this.selectedIngredient,
    required this.onIngredientsUpdated,
  });

  final IngredientModel selectedIngredient;
  final SelectedIngredientsManager selectedIngredients =
      SelectedIngredientsManager();
  final Function() onIngredientsUpdated;

  @override
  State<ingredientCart_Card> createState() => _ingredientCartState();
}

class _ingredientCartState extends State<ingredientCart_Card> {
  @override
  Widget build(BuildContext context) {
    final currentQuantity = widget.selectedIngredients.getIngredientQuantity(
      widget.selectedIngredient,
    );
    return SizedBox(
      width: 327.w,
      height: 100.h,
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Row(
            spacing: 8.w,
            children: [
              SizedBox(
                width: 76.w,
                child: Image.network(
                  widget.selectedIngredient.image_url,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: 76.w,
                      child: Container().redacted(
                        context: context,
                        redact: true,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      width: 76.w,
                      child: SizedBox(
                        width: 30.w,
                        height: 40.h,
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey[600],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.selectedIngredient.food_name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(fontSize: 14.sp),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${widget.selectedIngredient.calories} cal",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text("\$ 12", style: Theme.of(context).textTheme.bodyLarge),
                  const Spacer(),
                  SizedBox(
                    width: 77.w,
                    height: 35.h,
                    child: FittedBox(
                      child: Row(
                        spacing: 10.w,
                        children: [
                          IconButton(
                            style: Theme.of(context).outlinedButtonTheme.style,
                            onPressed: () {
                              setState(() {
                                widget.selectedIngredients.addIngredient(
                                  widget.selectedIngredient,
                                );
                                widget.onIngredientsUpdated();
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                          Text(
                            currentQuantity.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          IconButton(
                            style: Theme.of(context).outlinedButtonTheme.style,
                            onPressed: () {
                              setState(() {
                                widget.selectedIngredients.removeIngredient(
                                  widget.selectedIngredient,
                                );
                                widget.onIngredientsUpdated();
                              });
                            },
                            icon: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
