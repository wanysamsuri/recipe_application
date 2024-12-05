import 'package:flutter/material.dart';
import 'package:recipe_application/model/dish_model.dart';
import 'package:recipe_application/utils/constant.dart';

class DishPage extends StatelessWidget {
  final Dish dish;

  const DishPage({
    Key? key,
    required this.dish,
  }) : super(key: key);

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
            dish.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                dish.urlImg,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Preparation Time: ${dish.timePrep}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Ingredients:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...dish.ingredients
                  .map((ingredient) => Text('- $ingredient'))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
