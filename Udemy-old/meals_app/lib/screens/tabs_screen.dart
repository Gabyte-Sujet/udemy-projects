import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;

  final List<Map<String, Object?>> screens = [
    {"page": CategoriesScreen(), "title": "Category"},
    {"page": FavoritesScreen(), "title": "Favorites"},
  ];

  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screens[selectedIndex]['title'] as String),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TabsScreen(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  leading: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.food_bank,
                      size: 30,
                    ),
                  ),
                  title: Text(
                    'Meals',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ListTile(
                  onTap: () =>
                      Navigator.of(context).pushNamed(FiltersScreen.routeName),
                  leading: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      size: 30,
                    ),
                  ),
                  title: Text(
                    'Filters',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // endDrawer: Drawer(
      //   child: Center(
      //     child: Text('hey'),
      //   ),
      // ),
      // drawer: InkWell(
      //   onTap: () => Navigator.of(context).pop(),
      //   child: Container(
      //     color: Colors.green,
      //     child: Center(
      //       child: Text('asd'),
      //     ),
      //   ),
      // ),
      body: screens[selectedIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite',
          )
        ],
      ),
    );
  }
}


// @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Meals'),
//           bottom: const TabBar(
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.category),
//                 text: 'Category',
//               ),
//               Tab(
//                 icon: Icon(Icons.star),
//                 text: 'Favorites',
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             CategoriesScreen(),
//             FavoritesScreen(),
//           ],
//         ),
//       ),
//     );
//   }