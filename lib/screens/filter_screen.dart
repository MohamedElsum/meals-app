import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter_screen';

  final void Function(Map<String,bool>) filterData;
  final Map<String,bool> currentFilters;

  FilterScreen({required this.currentFilters,required this.filterData});


  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  @override
  void initState() {
    super.initState();
    glutenFree = widget.currentFilters['gluten'] as bool;
    lactoseFree = widget.currentFilters['lactose'] as bool;
    vegetarian = widget.currentFilters['vegetarian'] as bool;
    vegan = widget.currentFilters['vegan'] as bool;
  }

  var glutenFree = false;
  var vegetarian = false;
  var vegan = false;
  var lactoseFree = false;
  
  Widget buildSwitchListTile(String title,String description,bool switchValue,ValueChanged fun){
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: switchValue,
        onChanged: fun,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
              onPressed: (){
                var selectedFilters = {
                  'gluten' : glutenFree,
                  'lactose' : lactoseFree,
                  'vegetarian' : vegetarian,
                  'vegan' : vegan,
                };
                widget.filterData(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Adjust your meals selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
                children: [
                  buildSwitchListTile('Gluten-free', 'Only include gluten-free meals', glutenFree, (value) {
                    setState(() {
                      glutenFree = value;
                    });
                  }),
                  buildSwitchListTile('Lactose-free', 'Only include lactose-free meals', lactoseFree, (value) {
                    setState(() {
                      lactoseFree = value;
                    });
                  }),
                  buildSwitchListTile('Vegetarian', 'Only include Vegetarian meals', vegetarian, (value) {
                    setState(() {
                      vegetarian = value;
                    });
                  }),
                  buildSwitchListTile('Vegan', 'Only include vegan meals', vegan, (value) {
                    setState(() {
                      vegan = value;
                    });
                  }),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
