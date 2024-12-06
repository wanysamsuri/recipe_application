import 'package:flutter/material.dart';
import 'package:recipe_application/model/dish_model.dart';
import 'package:recipe_application/utils/constant.dart';

class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _titleController = TextEditingController();
  final _imageController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();

  final List<String> ingredients = [];
  final List<String> steps = [];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        elevation: 0.0,
        backgroundColor: primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        centerTitle: true,
        title: Center(
          child: Text(
            'Add New Recipe',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Recipe Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _imageController,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _ingredientsController,
                decoration: InputDecoration(
                  labelText: 'Ingredient (add one at a time)',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  setState(() {
                    ingredients.add(value);
                    _ingredientsController.clear();
                  });
                },
              ),
              SizedBox(height: 16),
              Wrap(
                children: ingredients
                    .map((ingredient) => Chip(
                          label: Text(ingredient),
                          onDeleted: () {
                            setState(() {
                              ingredients.remove(ingredient);
                            });
                          },
                        ))
                    .toList(),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _stepsController,
                decoration: InputDecoration(
                  labelText: 'Steps (add one at a time)',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  setState(() {
                    steps.add(value);
                    _stepsController.clear();
                  });
                },
              ),
              SizedBox(height: 16),
              Wrap(
                children: steps
                    .map((step) => Chip(
                          label: Text(step),
                          onDeleted: () {
                            setState(() {
                              steps.remove(step);
                            });
                          },
                        ))
                    .toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final newDish = Dish(
                    title: _titleController.text,
                    urlImg: _imageController.text,
                    ingredients: ingredients,
                    steps: steps,
                    timePrep: '30 mins',
                  );

                  setState(() {
                    allDishes.add(newDish);
                  });

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: Text(
                  'Save Recipe',
                  style: TextStyle(color: secondaryColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
