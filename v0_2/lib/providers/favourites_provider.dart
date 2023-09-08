import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  // Init values
  FavouriteMealsNotifier() : super([]);
  // All methods which exist which can change the list
  bool toggleMealFavouriteStatus(Meal meal) {
    final isMealFavourite = state.contains(meal);
    // Creating new list is basically a desing philosophy enforced by RIVERPOD
    if (isMealFavourite) {
      state = state.where((element) => meal.id != element.id).toList();
      return false;
    } else {
      state = [
        ...state,
        meal
      ]; //... is spread operator which keeps all elements in a list and also add 'meal'
      return true;
    }
  }
}

final favouriteMealsProvider =
    // Optimized for cases where data can change
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>(
  // returns an instance of FavouriteMealsNotifier and the data type is List<Meal>
  (ref) {
    return FavouriteMealsNotifier();
  },
);
