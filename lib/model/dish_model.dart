// import 'dart:ui';

class Dish {
  final String title;
  final String urlImg;
  final String timePrep;
  final List<String> ingredients;
  final List<String> steps;

  const Dish({
    required this.title,
    required this.urlImg,
    required this.timePrep,
    required this.ingredients,
    required this.steps,
  });
}

List<Dish> allDishes = [
  const Dish(
    title: 'Spicy Creamy Pasta with Chicken Fillet',
    urlImg:
        'https://resepichenom.com/media/Creamy_Pasta_Pedas_Bersama_Fillet_Ayam_thumb_thumb.jpg',
    timePrep: '45 mins',
    ingredients: [
      '2tb butter',
      'Chicken fillet',
      'Cream sauce',
      'Spices (to taste)',
    ],
    steps: [],
  ),
  const Dish(
    title: 'Donut',
    urlImg:
        'https://resepichenom.com/media/cache/d9/6b/d96bf177583ec51596678184a3fc6cb4.jpg',
    timePrep: '1 hour',
    ingredients: [
      'Flour',
      'Sugar',
      'Yeast',
      'Oil for frying',
    ],
    steps: [],
  ),
  const Dish(
    title: 'Popia',
    urlImg:
        'https://resepichenom.com/media/cache/32/a8/32a866a304f7df27b342900279ed0117.jpg',
    timePrep: ' 30 mins',
    ingredients: [
      'Spring roll wrappers',
      'Vegetable filling',
      'Oil for frying',
    ],
    steps: [],
  ),
  const Dish(
    title: 'Daging Black Pepper',
    urlImg:
        'https://resepichenom.com/media/Daging_Black_Pepper_thumb_thumb.jpg',
    timePrep: '45 mins',
    ingredients: [
      '300g beef',
      '1 tbsp oyster sauce',
      '1 tbsp light soy sauce',
      '1 tbsp black pepper powder',
      '2 tbsp sweet soy sauce',
      '1/4 cup cooking oil',
      '3 cloves garlic',
      '1/2 inch ginger',
      'Water (for gravy)',
      '1/2-1 tbsp black pepper powder',
      '1/2 onion',
      '1 bell pepper (mixed colors)',
      '1 stalk spring onion',
      '2 tbsp oyster sauce',
      '2 tbsp sweet soy sauce',
      '1 tbsp light soy sauce',
      '1 tbsp cornstarch',
      'Water',
    ],
    steps: [],
  ),
  const Dish(
    title: 'Double Chocolate Chips Muffin',
    urlImg: 'https://resepichenom.com/media/Double_Chocolate_Chip_Muffin.webp',
    timePrep: '40 mins',
    ingredients: [
      '1 cup (250ml) fresh milk or full cream',
      '2 tbsp lemon juice or vinegar',
      '3/4 cup (170g) caster sugar',
      '1/2 cup (120g) corn oil',
      '2 large eggs',
      '1 tsp vanilla essence',
      '2 cups (250g) all-purpose flour',
      '1/2 cup (50g) cocoa powder',
      '1 1/2 tsp baking soda',
      '1/2 tsp baking powder',
      '1/4 tsp salt',
      '1 cup (170g) chocolate chips (for batter)',
      '1 cup (170g) chocolate chips (for topping)',
    ],
    steps: [],
  )
];
