import 'package:flutter/material.dart';

class FilterItem extends StatefulWidget {
  const FilterItem({
    super.key,
    required this.filterTitle,
    required this.filterSubTitle,
  });
  final String filterTitle;
  final String filterSubTitle;
  @override
  State<FilterItem> createState() {
    return FilterItemState();
  }
}

class FilterItemState extends State<FilterItem> {
  bool filterSet = false;
  bool get getSwitchState {
    return filterSet;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: filterSet,
      onChanged: (val) {
        setState(() {
          filterSet = val;
        });
      },
      title: Text(
        widget.filterTitle,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        widget.filterSubTitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 30, right: 20),
    );
  }
}
