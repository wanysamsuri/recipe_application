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
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  String? selectedItem;

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
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text('Others'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: DropdownButton<String>(
                    value: selectedItem,
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(fontSize: 12),
                              ),
                            ))
                        .toList(),
                    onChanged: (item) => setState(() => selectedItem = item))),
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
                      color: const Color.fromARGB(255, 241, 245, 234),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Image.network(
                        dish.urlImg,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(dish.title),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DishPage(dish: dish))),
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
        backgroundColor: primaryColor,
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
