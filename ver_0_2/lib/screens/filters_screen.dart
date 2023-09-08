import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
    // required this.currentFilters,
  });

  // final Map<Filters, bool> currentFilters;
  // @override
  // void initState() {
  //   // Runs before build method
  //   // This is a workaround to set values initially
  //   super.initState();
  //   final activeFilters = ref.read(filtersProvider);
  //   _glutenFreeFilterSet = activeFilters[Filters.glutenFree]!;
  //   _lactoseFreeFilterSet = activeFilters[Filters.lactoseFree]!;
  //   _veganFilterSet = activeFilters[Filters.vegan]!;
  //   _vegetarianFilterSet = activeFilters[Filters.vegetarian]!;
  // }//

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: TabDrawer(onSelectScreen: (identifer) {
      //   if (identifer == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(builder: (context) => const TabsScreen()),
      //     );
      //   }
      // }),
      // body: WillPopScope(
      //   onWillPop: () async {
      //     // Kind of allows you to wrap the false value in a FUTURE
      //     ref.read(filtersProvider.notifier).setFilters({
      //       Filters.glutenFree: _glutenFreeFilterSet,
      //       Filters.lactoseFree: _lactoseFreeFilterSet,
      //       Filters.vegetarian: _vegetarianFilterSet,
      //       Filters.vegan: _veganFilterSet,
      //     });
      //     // Navigator.of(context).pop();
      //     // We did it manually initially because we wanted to pass some data along
      //     return true; // To confirm whether we want to manually go back and not pop twice
      //   },
      body: Column(
        children: [
          // Different filters on or off (ROW)... LIst full of widgets
          SwitchListTile(
            value: activeFilters[Filters.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-Free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only includes Gluten-Free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 30, right: 20),
          ),
          SwitchListTile(
            value: activeFilters[Filters.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-Free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only includes Lactose-Free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 30, right: 20),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only includes Vegan meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 30, right: 20),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filters.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only includes Vegan meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 30, right: 20),
          ),
        ],
      ),
    );
  }
}
