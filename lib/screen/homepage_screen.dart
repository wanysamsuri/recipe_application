import 'package:flutter/material.dart';
import 'package:recipe_application/model/dish_model.dart';
import 'package:recipe_application/screen/add_recipes.dart';
import 'package:recipe_application/screen/dish_page.dart';
import 'package:recipe_application/screen/edit_dish.dart';
import 'package:recipe_application/screen/food_page_body.dart';
import 'package:recipe_application/utils/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  List<Dish> dishes = List.from(allDishes);
  String? selectedDishTitle;
  Dish? selectedDish;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.05,
        elevation: 0.0,
        backgroundColor: primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Center(
            child: Text(
          'Recipe Application',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Search Bar
            Container(
              margin: const EdgeInsets.all(16),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Dish Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: primaryColor))),
                onChanged: searchDish,
              ),
            ),
            FoodPageBody(dishes: dishes),
            SizedBox(height: 10),
            Text('Others'),
            SizedBox(height: 10),

            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 245, 234),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                value: selectedDish?.title, // Show the selected dish's title
                items: dishes.map((dish) {
                  return DropdownMenuItem<String>(
                    value: dish.title,
                    child: Text(dish.title, style: TextStyle(fontSize: 12)),
                  );
                }).toList(),
                onChanged: (title) {
                  setState(() {
                    // Update the selected dish based on title
                    selectedDish =
                        dishes.firstWhere((dish) => dish.title == title);
                  });
                },
              ),
            ),

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dishes.length,
              itemBuilder: (context, index) {
                final dish = dishes[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedDish?.title == dish.title
                          ? sixthColor
                          : primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selectedDish?.title == dish.title
                            ? primaryColor
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      leading: Image.network(
                        dish.urlImg,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(dish.title),
                      onTap: () {
                        setState(() {
                          selectedDish = dish;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DishPage(dish: dish),
                          ),
                        );
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              final updatedDish = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditRecipePage(dish: dish),
                                ),
                              );

                              if (updatedDish != null) {
                                setState(() {
                                  dishes[index] = updatedDish;
                                  if (selectedDish?.title == dish.title) {
                                    selectedDish = updatedDish;
                                  }
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteDish(dish);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRecipePage()),
          ).then((newDish) {
            if (newDish != null) {
              setState(() {
                dishes.add(newDish);
              });
            }
          });
        },
        child: Icon(Icons.add),
        backgroundColor: sixthColor,
        tooltip: 'Add Recipe',
      ),
    );
  }

  void searchDish(String query) {
    final suggestions = allDishes.where((dish) {
      final dishTitle = dish.title.toLowerCase();
      final input = query.toLowerCase();
      return dishTitle.contains(input);
    }).toList();

    setState(() => dishes = suggestions);
  }

  void _deleteDish(Dish dish) {
    setState(() {
      dishes.remove(dish);
    });
  }
}
