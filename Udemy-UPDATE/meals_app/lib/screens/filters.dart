// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../providers/filters_provider.dart';

// class FiltersScreen extends ConsumerStatefulWidget {
//   const FiltersScreen({
//     Key? key,
//     // required this.currentFilters,
//   }) : super(key: key);

//   // final Map<Filter, bool> currentFilters;

//   @override
//   ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
// }

// class _FiltersScreenState extends ConsumerState<FiltersScreen> {
//   bool _isGlutenFree = false;
//   bool _isLactoseFree = false;
//   bool _isVegetarian = false;
//   bool _isVegan = false;

//   @override
//   void initState() {
//     super.initState();
//     final activeFilters = ref.read(filtersProvider);

//     _isGlutenFree = activeFilters[Filter.glutenFree]!;
//     _isLactoseFree = activeFilters[Filter.lactoseFree]!;
//     _isVegan = activeFilters[Filter.vegan]!;
//     _isVegetarian = activeFilters[Filter.vegetarian]!;
//     // _isGlutenFree = widget.currentFilters[Filter.glutenFree]!;
//     // _isLactoseFree = widget.currentFilters[Filter.lactoseFree]!;
//     // _isVegan = widget.currentFilters[Filter.vegan]!;
//     // _isVegetarian = widget.currentFilters[Filter.vegetarian]!;
//   }

//   void toggleFilter(bool val, String filterName) {
//     setState(() {
//       switch (filterName) {
//         case 'gluten-free':
//           // _isGlutenFree = val;
//           _isGlutenFree = !_isGlutenFree;
//           return;
//         case 'lactose-free':
//           _isLactoseFree = !_isLactoseFree;
//           return;
//         case 'Vegetarian':
//           _isVegetarian = !_isVegetarian;
//           return;
//         case 'Vegan':
//           _isVegan = !_isVegan;
//           return;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Filters'),
//       ),
//       body: WillPopScope(
//         onWillPop: () async {
//           ref.read(filtersProvider.notifier).setFilters({
//             Filter.glutenFree: _isGlutenFree,
//             Filter.lactoseFree: _isLactoseFree,
//             Filter.vegetarian: _isVegetarian,
//             Filter.vegan: _isVegan,
//           });
//           // Navigator.of(context).pop({
//           //   Filter.glutenFree: _isGlutenFree,
//           //   Filter.lactoseFree: _isLactoseFree,
//           //   Filter.vegetarian: _isVegetarian,
//           //   Filter.vegan: _isVegan,
//           // });
//           // return false;
//           return true;
//         },
//         child: Column(
//           children: [
//             SwitchListTile(
//               value: _isGlutenFree,
//               onChanged: (val) {
//                 toggleFilter(val, 'gluten-free');
//               },
//               title: Text(
//                 'Gluten-free',
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//               subtitle: Text(
//                 'Only include Gluten-free',
//                 style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//               activeColor: Theme.of(context).colorScheme.tertiary,
//               contentPadding: const EdgeInsets.only(
//                 left: 30,
//                 right: 15,
//               ),
//             ),
//             SwitchListTile(
//               value: _isLactoseFree,
//               onChanged: (val) {
//                 toggleFilter(val, 'lactose-free');
//               },
//               title: Text(
//                 'Lactose-free',
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//               subtitle: Text(
//                 'Only include Lactose-free',
//                 style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//               activeColor: Theme.of(context).colorScheme.tertiary,
//               contentPadding: const EdgeInsets.only(
//                 left: 30,
//                 right: 15,
//               ),
//             ),
//             SwitchListTile(
//               value: _isVegetarian,
//               onChanged: (val) {
//                 toggleFilter(val, 'Vegetarian');
//               },
//               title: Text(
//                 'Vegetarian',
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//               subtitle: Text(
//                 'Only include Vegetarian',
//                 style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//               activeColor: Theme.of(context).colorScheme.tertiary,
//               contentPadding: const EdgeInsets.only(
//                 left: 30,
//                 right: 15,
//               ),
//             ),
//             SwitchListTile(
//               value: _isVegan,
//               onChanged: (val) {
//                 toggleFilter(val, 'Vegan');
//               },
//               title: Text(
//                 'Vegan',
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//               subtitle: Text(
//                 'Only include Vegan',
//                 style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onBackground,
//                     ),
//               ),
//               activeColor: Theme.of(context).colorScheme.tertiary,
//               contentPadding: const EdgeInsets.only(
//                 left: 30,
//                 right: 15,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include Gluten-free',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(
              left: 30,
              right: 15,
            ),
          ),
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include Lactose-free',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(
              left: 30,
              right: 15,
            ),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include Vegetarian',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(
              left: 30,
              right: 15,
            ),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include Vegan',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(
              left: 30,
              right: 15,
            ),
          ),
        ],
      ),
    );
  }
}
