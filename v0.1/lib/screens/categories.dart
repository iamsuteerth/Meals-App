import 'package:flutter/material.dart';
import 'package:meals_app/data/dumm_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });
  final List<Meal> availableMeals;

  void selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();
    Navigator.push(
      context,
      // This is used to open a new screen
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
    // Pushes a screen on a stack, the user seeing the TOP of screen
    // Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category).toList())
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () => selectCategory(context, category),
            ),
        ],
      ),
    );
  }
}
