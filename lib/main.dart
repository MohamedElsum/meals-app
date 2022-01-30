import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/screens/tab_screen.dart';
import 'screens/categories_screen.dart';
import 'package:meals_app/models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String , bool> filters = {
    'gluten' : false,
    'lactose' : false,
    'vegetarian' : false,
    'vegan' : false,
  };

  List<Meal> availableMeals = dummy_Meals;
  List<Meal> favoriteMeals = [];

  void setFilters(Map<String,bool> filterData){
    setState(() {
      filters = filterData;

      availableMeals = dummy_Meals.where((meal){
        if(filters['gluten'] == true && !meal.isGlutenFree){
          return false;
        }
        if(filters['lactose'] == true && !meal.isLactoseFree){
          return false;
        }
        if(filters['vegetarian'] == true && !meal.isVegetarian){
          return false;
        }
        if(filters['vegan'] == true && !meal.isVegan){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorite(String mealId){
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >=0){
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        favoriteMeals.add(dummy_Meals.firstWhere((meal) => meal.id == mealId ));
      });
    }
  }

  bool isMealFavorite(String id){
    return favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          headline6: TextStyle(
            fontSize: 25.0,
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //home: TabScreen(favoriteMeals: favoriteMeals,),
      routes: {
        '/' : (ctx) => TabScreen(favoriteMeals: favoriteMeals,),
        CategoryMeals.routeName : (ctx) => CategoryMeals(availableMeals: availableMeals,),
        MealDetailScreen.routeName : (ctx) => MealDetailScreen(toggleFavorite: toggleFavorite,isMealFavorite: isMealFavorite,),
        FilterScreen.routeName : (ctx) => FilterScreen(filterData: setFilters,currentFilters: filters,),
      },
      onGenerateRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
