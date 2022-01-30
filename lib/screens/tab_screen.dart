import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorite_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/models/meal.dart';

class TabScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;
  TabScreen({required this.favoriteMeals});

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  List<Map<String,Object?>> pages = [{}] ;

  var selectedPageIndex = 0;

  void selectPage(int index){
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pages = [
      {'page' : CategoriesScreen() , 'title' : 'Categories'},
      {'page' : FavoriteScreen(favoriteMeals: widget.favoriteMeals,) , 'title' : 'Favorite Meals'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pages[selectedPageIndex]['title']}'),
      ),
      drawer: MainDrawer(),
      body: pages[selectedPageIndex]['page'] as Widget?,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
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
