import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/widgets/meal_item.dart';
import 'package:meals_app/models/meal.dart';

class CategoryMeals extends StatefulWidget {
  static const routeName = '/category_meals';

  final List<Meal> availableMeals;

  CategoryMeals({required this.availableMeals});

  @override
  State<CategoryMeals> createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {

  String categoryTitle = '';
  List<Meal> displayedMeals =[];
  var loadedData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!loadedData){
      final routeArgs =
      ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'] as String;
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      loadedData = true;
    }
  }

  void removeMeal(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability);
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
