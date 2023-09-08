import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item_metadata.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    // name gives us value to enum as a string
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1, meal.complexity.name.length);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(
          1,
          meal.affordability.name.length,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsetsDirectional.symmetric(
        vertical: 15,
        horizontal: 8,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          // Start with background of stack
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Hero(
                tag: meal.id, // Every image should get its own tag
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                ),
              ),
            ),
            Positioned(
              // Positioning of child
              // Also enforces the container to take exactly the width specified which is then passed onto children
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap:
                          true, // Smooth and good looking wrapping of text
                      overflow: TextOverflow.ellipsis, // Adds ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemMetaData(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                          isVegetarian: meal.isVegetarian,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        MealItemMetaData(
                          icon: Icons.work,
                          label: complexityText,
                          isVegetarian: meal.isVegetarian,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        MealItemMetaData(
                            icon: Icons.attach_money,
                            label: affordabilityText,
                            isVegetarian: meal.isVegetarian),
                        const SizedBox(
                          width: 6,
                        ),
                        if (meal.isVegetarian)
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                Icons.square,
                                color: Colors.white,
                                size: 24,
                              ),
                              Icon(
                                Icons.crop_square_sharp,
                                color: Colors.green.shade800.withOpacity(0.85),
                                size: 24,
                              ),
                              Icon(Icons.circle,
                                  color:
                                      Colors.green.shade800.withOpacity(0.85),
                                  size: 8),
                            ],
                          ),
                        if (!meal.isVegetarian)
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                Icons.square,
                                color: Colors.white,
                                size: 24,
                              ),
                              Icon(
                                Icons.crop_square_sharp,
                                color: Colors.red.shade800.withOpacity(0.85),
                                size: 24,
                              ),
                              Icon(Icons.circle,
                                  color: Colors.red.shade800.withOpacity(0.85),
                                  size: 8),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
