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
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 245, 234),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedDish?.title ?? "Select a dish",
                      items: [
                        DropdownMenuItem<String>(
                          value: "Select a dish",
                          child: Text("Select a dish",
                              style: TextStyle(fontSize: 12)),
                        ),
                        ...dishes.map((dish) {
                          return DropdownMenuItem<String>(
                            value: dish.title,
                            child: Text(dish.title,
                                style: TextStyle(fontSize: 12)),
                          );
                        }).toList(),
                      ],
                      onChanged: (title) {
                        setState(() {
                          if (title == "Select a dish") {
                            selectedDish = null;
                          } else {
                            selectedDish = dishes
                                .firstWhere((dish) => dish.title == title);
                          }
                        });
                      },
                      underline: SizedBox.shrink(),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDish = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: selectedDish == null
                  ? dishes.length
                  : 1, // Show 1 if selected
              itemBuilder: (context, index) {
                final dish =
                    selectedDish ?? dishes[index]; // Show all or selected
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedDish?.title == dish.title
                          ? primaryColor
                          : primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //   color: selectedDish?.title == dish.title
                      //       ? primaryColor
                      //       : Colors.transparent,
                      //   width: 2,
                      // ),
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
                                  if (selectedDish?.title == dish.title) {
                                    selectedDish = updatedDish;
                                  }
                                  final index = dishes.indexWhere(
                                      (d) => d.title == updatedDish.title);
                                  if (index != -1) {
                                    dishes[index] = updatedDish;
                                  }
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                dishes.remove(dish);
                                if (selectedDish?.title == dish.title) {
                                  selectedDish = null;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
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
