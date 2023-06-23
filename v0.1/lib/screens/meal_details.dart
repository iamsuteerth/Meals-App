import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';
import 'package:meals_app/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favouriteMealsProvider);
    final bool isFavorite = favoriteMeals.contains(meal);
    // ref needed by riverpod
    return Scaffold(
      appBar: AppBar(
        actions: [
          // We can't manage the state required for managing favourites from here because we need to access it from tabs.dart for example
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleMealFavouriteStatus(
                      meal); // .notifer gives us access to the notifier class we made
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(
                    milliseconds: 1500,
                  ),
                  content: Text(wasAdded
                      ? "Added ${meal.title.toString()} to Favorites!"
                      : "Removed ${meal.title.toString()} from Favorites!"),
                ),
              );
            },
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          ),
        ],
        title: Text(
          meal.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(meal.imageUrl),
                    ),
                  ),
                  if (meal.isVegetarian)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.square,
                          color: Colors.white,
                          size: 36,
                        ),
                        Icon(
                          Icons.crop_square_sharp,
                          color: Colors.green.shade800.withOpacity(0.8),
                          size: 36,
                        ),
                        Icon(Icons.circle,
                            color: Colors.green.shade800.withOpacity(0.8),
                            size: 14),
                      ],
                    ),
                  if (!meal.isVegetarian)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.square,
                          color: Colors.white,
                          size: 36,
                        ),
                        Icon(
                          Icons.crop_square_sharp,
                          color: Colors.red.shade800.withOpacity(0.8),
                          size: 36,
                        ),
                        Icon(Icons.circle,
                            color: Colors.red.shade800.withOpacity(0.8),
                            size: 14),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 4,
            ),
            for (final ingredient in meal.ingredients)
              Text(
                "• $ingredient",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 16,
                    ),
              ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 4,
            ),
            for (final step in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Text(
                  "• $step",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16,
                      ),
                ),
              ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
