import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal_details';

  final void Function(String) toggleFavorite;
  final Function(String) isMealFavorite;

  MealDetailScreen({required this.toggleFavorite,required this.isMealFavorite});

  Widget buildContainerTitle(BuildContext ctx, String text) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0)),
      width: 280.0,
      height: 150.0,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = dummy_Meals.firstWhere((meal) {
      return meal.id == mealId;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250.0,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildContainerTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${selectedMeal.ingredients[index]}'),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildContainerTitle(context, 'steps'),
            buildContainer(
              ListView.builder(
                  itemBuilder: (ctx,index){
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('#${index+1}'),
                      ),
                      title: Text('${selectedMeal.steps[index]}'),
                    );
                  },
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            isMealFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: (){
          toggleFavorite(mealId);
        },
      ),
    );
  }
}
