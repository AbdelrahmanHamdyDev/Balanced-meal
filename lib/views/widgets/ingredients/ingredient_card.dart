import 'package:balanced_meal/controllers/SelectedIngredientsManager.dart';
import 'package:balanced_meal/models/ingredient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redacted/redacted.dart';

class ingredientCard extends StatefulWidget {
  ingredientCard({
    super.key,
    required this.ingredient,
    required this.onIngredientsUpdated,
  });

  final IngredientModel ingredient;
  final SelectedIngredientsManager selectedIngredients =
      SelectedIngredientsManager();
  final Function() onIngredientsUpdated;

  @override
  State<ingredientCard> createState() => _ingredientCardState();
}

class _ingredientCardState extends State<ingredientCard> {
  @override
  Widget build(BuildContext context) {
    final currentQuantity = widget.selectedIngredients.getIngredientQuantity(
      widget.ingredient,
    );
    return SizedBox(
      width: 183.w,
      height: 220.h,
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
          //image
          child: Column(
            spacing: 10.h,
            children: [
              Image.network(
                widget.ingredient.image_url,
                width: 163.w,
                height: 108.h,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: 163.w,
                    height: 108.h,
                    child: Container().redacted(context: context, redact: true),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: 163.w,
                    height: 108.h,
                    child: SizedBox(
                      width: 30.w,
                      height: 40.h,
                      child: Icon(Icons.broken_image, color: Colors.grey[600]),
                    ),
                  );
                },
              ),
              //under_image
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: Text(
                      widget.ingredient.food_name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    "${widget.ingredient.calories} cal",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text("\$12", style: Theme.of(context).textTheme.bodyLarge),
                  const Spacer(),
                  if (currentQuantity <= 0)
                    SizedBox(
                      width: 77.w,
                      height: 35.h,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.selectedIngredients.addIngredient(
                              widget.ingredient,
                            );
                            widget.onIngredientsUpdated();
                          });
                        },
                        style: Theme.of(context).elevatedButtonTheme.style!,
                        child: const Text("Add"),
                      ),
                    ),
                  if (currentQuantity > 0)
                    SizedBox(
                      width: 77.w,
                      height: 35.h,
                      child: FittedBox(
                        child: Row(
                          spacing: 10.w,
                          children: [
                            IconButton(
                              style:
                                  Theme.of(context).outlinedButtonTheme.style,
                              onPressed: () {
                                setState(() {
                                  widget.selectedIngredients.addIngredient(
                                    widget.ingredient,
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
                              style:
                                  Theme.of(context).outlinedButtonTheme.style,
                              onPressed: () {
                                setState(() {
                                  widget.selectedIngredients.removeIngredient(
                                    widget.ingredient,
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
