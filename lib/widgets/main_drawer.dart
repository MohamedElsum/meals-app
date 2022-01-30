import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/tab_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(String title,IconData icon,VoidCallback tapHandler){
    return ListTile(
      leading: Icon(
        icon,
        size: 28.0,
      ),
      title: Text(
        title,style: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto Condensed',
      ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 130.0,
            color: Theme.of(context).accentColor,
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking Up!!',
              style: TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: Theme.of(context).primaryColor,
            ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          buildListTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushNamed('/');
          }),
          buildListTile('Filters',Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          }),
        ],
      ),
    );
  }
}
