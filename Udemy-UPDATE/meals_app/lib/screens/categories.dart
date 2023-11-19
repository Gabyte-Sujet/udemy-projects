import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

class Categories extends StatefulWidget {
  const Categories({
    Key? key,
    // required this.onToggleFavorite,
    required this.availableMeals,
    required this.backFromFiltersActive,
  }) : super(key: key);

  final bool backFromFiltersActive;

  // final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      // lowerBound: 0,
      // upperBound: 100,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          // onToggleFavorite: onToggleFavorite,
        ),
      ),
    );

    // Navigator.push(context, route); // same
  }

  @override
  Widget build(BuildContext context) {
    print(widget.backFromFiltersActive);
    if (widget.backFromFiltersActive) {
      _animationController.reset();
      _animationController.forward();
    }

    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(20),
        // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //   maxCrossAxisExtent: 100,
        //   // mainAxisExtent: 100,
        //   childAspectRatio: 1,
        //   crossAxisSpacing: 20,
        //   mainAxisSpacing: 20,
        // ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          // mainAxisExtent: 200,
        ),
        // children: [
        //   for (final category in availableCategories)
        //     CategoryGridItem(category: category)
        // ],
        children: availableCategories
            .map(
              (category) => CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              ),
            )
            .toList(),
      ),
      builder: (context, child) {
        return SlideTransition(
          // position: _animationController.drive(
          //   Tween(
          //     begin: const Offset(0.0, 0.3),
          //     end: const Offset(0.0, 0.0),
          //   ),
          // ),
          position: Tween(
            begin: const Offset(0.0, 0.3),
            end: const Offset(0.0, 0.0),
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
        // return Padding(
        //   padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
        //   child: Opacity(
        //     opacity: _animationController.value,
        //     child: child,
        //   ),
        // );
      },
    );
  }
}
