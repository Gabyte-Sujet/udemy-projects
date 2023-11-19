import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeals = [];
  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       duration: const Duration(seconds: 1),
  //       content: Text(message),
  //     ),
  //   );
  // }

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal deleted');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //     });
  //     _showInfoMessage('Meal added');
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  bool backFromFilters = false;

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      Navigator.of(context)
          .push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
          // builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      )
          .then((value) {
        setState(() {
          backFromFilters = true;
        });
      });
      // final result = await Navigator.of(context).push<Map<Filter, bool>>(
      //   MaterialPageRoute(
      //     builder: (ctx) => const FiltersScreen(),
      //     // builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
      //   ),
      // );

      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    }

    // switch (identifier) {
    //   case 'meals':
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (ctx) =>
    //             MealsScreen(meals: meals, onToggleFavorite: onToggleFavorite),
    //       ),
    //     );
    // }
  }

  @override
  Widget build(BuildContext context) {
    print('tabs: $backFromFilters');
    // final meals = ref.watch(mealsProvider);
    // final activeFilters = ref.watch(filtersProvider);

    // final availableMeals = meals.where((meal) {
    //   // if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
    //   //   return false;
    //   // }
    //   if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegan]! && !meal.isVegan) {
    //     return false;
    //   }

    //   return true;
    // }).toList();

    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = Categories(
      // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
      backFromFiltersActive: backFromFilters,
    );

    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activePage = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
