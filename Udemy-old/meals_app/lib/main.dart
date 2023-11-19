import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'screens/filters_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli Meals',
      theme: ThemeData.dark(),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) {
          final currentRoute = ModalRoute.of(context)?.settings.name;
          print('currentRoute: $currentRoute');

          return TabsScreen();
          // return CategoriesScreen();
        },
        CategoryMealsScreen.routeName: (context) {
          final currentRoute = ModalRoute.of(context)?.settings.name;
          print('currentRoute: $currentRoute');
          return CategoryMealsScreen();
        },
        FiltersScreen.routeName: (context) => FiltersScreen(),

        // MealDetailScreen.routeName: (context) => MealDetailScreen(),
      },
      onGenerateRoute: (settings) {
        print('settings name: ${settings.name}');
        print('settings arguments: ${settings.arguments}');
        return MaterialPageRoute(
          builder: (context) {
            return MealDetailScreen();
          },
          settings: RouteSettings(arguments: settings.arguments),
          fullscreenDialog: true,
        );
      },
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(
      //       builder: (ctx) => MealDetailScreen(),
      //       settings: RouteSettings(arguments: 'unknownRoute'),);
      // },
    );
  }
}
