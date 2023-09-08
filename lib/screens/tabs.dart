// TabBar allows you to load and embed other screens
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/screens/tab_drawer.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

const Map<Filters, bool> initialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarian: false,
};

// Very Important CONCEPT wise as a tabbar is something which is VERY frequently used
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0; // Default

  Future<void> _setScreen(String identifer) async {
    Navigator.of(context).pop();
    if (identifer == 'filters') {
      await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index; // Update selected page index
    });
  }

  // void toggleMealFavoriteStatus(Meal meal) {
  //   // 1. Pass this function from tabs screen to Meals Screen
  //   // 2. Then pass it to categories
  //   // Passing pointer from tabs to meal details screen
  //   final isExisting = favouriteMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _showInfoMessage("Removed ${meal.title.toString()} from Favorites!");
  //       favouriteMeals.remove(meal); // Update selected page index
  //     });
  //   } else {
  //     setState(() {
  //       _showInfoMessage("Added ${meal.title.toString()} to Favorites!");
  //       favouriteMeals.add(meal); // Update selected page index
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = 'Categories';
    // final initMeals =
    //     ref.watch(mealsProvider); // Recommneded to always use first
    final availableMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(
          favouriteMealsProvider); // Extracts state from the notifier class that belongs to the provider
      activePage = MealsScreen(
        meals: favoriteMeals,
        // The function pointer is passed to the MealsScreen through the MealsScreen in the end to the MealsDetails screen when this category is called
      );
      activePageTitle = "Your Favorites";
    }
    // Side drawer is implemented PER scaffold
    // Here, adding it on the TABS screen implements it on FAV and CATEGORIES screen
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: TabDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        // Widget built into flutter,
        currentIndex:
            _selectedPageIndex, // To make sure flutter knows which page is selected
        onTap: (index) {
          _selectPage(index);
        }, // Executed whenever user taps on an item, gets index called by flutter
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ], // List of TABS
      ),
    );
  }
}
