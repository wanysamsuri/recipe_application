import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:recipe_application/screen/homepage_screen.dart';
import 'package:recipe_application/screen/dish_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: <String, WidgetBuilder>{
          '/homepage': ((context) => const HomePage()),
        });
  }
}
