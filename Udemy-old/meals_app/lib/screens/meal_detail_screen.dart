import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/meal_detail';

  @override
  Widget build(BuildContext context) {
    var mealId = ModalRoute.of(context)?.settings.arguments as String;
    var selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(mealId),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                selectedMeal.title,
                style: TextStyle(fontSize: 30, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(mealId);
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}
