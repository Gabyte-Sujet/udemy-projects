import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  const CategoryMealsScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/category_meals';

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  late List<Meal> categoryMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments != null
          ? ModalRoute.of(context)?.settings.arguments as Map<String, Object?>
          : {"id": "null --"};
      categoryTitle = routeArgs['title'] as String;
      final categoryId = routeArgs['id'];
      categoryMeals = DUMMY_MEALS
          .where((meal) => meal.categories.contains(categoryId))
          .toList();

      _loadedInitData = true;
    }
  }

  void removeItem(String mealId) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  // @override
  // void initState() {
  //   super.initState();

  //   final routeArgs = ModalRoute.of(context)?.settings.arguments != null
  //       ? ModalRoute.of(context)?.settings.arguments as Map<String, Object?>
  //       : {"id": "null --"};
  //   categoryTitle = routeArgs['title'] as String;
  //   final categoryId = routeArgs['id'];
  //   categoryMeals = DUMMY_MEALS
  //       .where((meal) => meal.categories.contains(categoryId))
  //       .toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle.toString()),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (context, index) {
          return MealItem(
            title: categoryMeals[index].title,
            id: categoryMeals[index].id,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
            removeItem: removeItem,
          );
        },
      ),
    );
  }
}
