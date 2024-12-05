import 'package:flutter/material.dart';
import 'package:recipe_application/model/dish_model.dart';
import 'package:recipe_application/utils/constant.dart';

class EditRecipePage extends StatefulWidget {
  final Dish dish;

  const EditRecipePage({Key? key, required this.dish}) : super(key: key);

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  late TextEditingController titleController;
  late TextEditingController timeController;
  late List<TextEditingController> ingredientControllers;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.dish.title);
    timeController = TextEditingController(text: widget.dish.timePrep);
    ingredientControllers = widget.dish.ingredients
        .map((ingredient) => TextEditingController(text: ingredient))
        .toList();
  }

  @override
  void dispose() {
    titleController.dispose();
    timeController.dispose();
    for (var controller in ingredientControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void saveChanges() {
    final updatedDish = Dish(
      title: titleController.text,
      urlImg: widget.dish.urlImg, // Keeping the same image URL
      timePrep: timeController.text,
      ingredients:
          ingredientControllers.map((controller) => controller.text).toList(),
      steps: widget.dish.steps, // Assuming no change in steps
    );

    Navigator.pop(context, updatedDish);
  }

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
        title: Text(
          titleController.text.isEmpty ? "Edit Recipe" : titleController.text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Preparation Time'),
              ),
              SizedBox(height: 10),
              Text('Ingredients'),
              ...ingredientControllers.map((controller) {
                return TextField(
                  controller: controller,
                  decoration: InputDecoration(labelText: 'Ingredient'),
                );
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Create a new Dish object using the input data
                  final updatedDish = Dish(
                    title: titleController.text, // Title from the controller
                    urlImg: widget.dish.urlImg, // Keeping the same image URL
                    ingredients: ingredientControllers
                        .map((controller) => controller.text)
                        .toList(), // List of ingredients
                    steps: widget.dish.steps, // Keeping the same steps
                    timePrep: timeController.text, // Time from the controller
                  );

                  // Pop the current screen and pass the updated dish back
                  Navigator.pop(context, updatedDish);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Set the background color
                ),
                child: Text(
                  'Save Changes', // Text displayed on the button
                  style: TextStyle(color: secondaryColor), // Set text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
