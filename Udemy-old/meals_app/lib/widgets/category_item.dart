import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.color,
    required this.title,
    required this.id,
  }) : super(key: key);

  final String id;
  final String title;
  final Color color;

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );

    // fullscreendialog from pushNamed:
    // https://stackoverflow.com/questions/58755264/how-to-open-fullscreen-dialog-using-navigator-pushnamed-in-flutter

    // Navigator.of(ctx).push(
    //   MaterialPageRoute(
    //     builder: (context) => CategoryMealsScreen(),
    //     settings: RouteSettings(arguments: {
    //       "title": title,
    //       "id": id,
    //     }),
    //     fullscreenDialog: true,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Colors.lightBlue,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
