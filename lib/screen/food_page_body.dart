import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:recipe_application/model/dish_model.dart';
import 'package:recipe_application/screen/dish_page.dart';
import 'package:recipe_application/utils/constant.dart';
import 'package:recipe_application/utils/dimension.dart';
import 'package:recipe_application/utils/icon.dart';
import 'package:recipe_application/utils/small_text.dart';

class FoodPageBody extends StatefulWidget {
  final List<Dish> dishes;

  const FoodPageBody({super.key, required this.dishes});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  var _currentPage = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimension.pageViewContainer;
  late List<Dish> dishes;
  PageController pageController = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
    dishes = widget.dishes;
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
        print('Current value: ' + _currentPage.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: Dimension.pageView,
          child: PageView.builder(
              controller: pageController,
              itemCount: dishes.length,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        DotsIndicator(
          dotsCount: dishes.length,
          position: _currentPage.floor(),
          decorator: DotsDecorator(
              activeColor: fifthColor,
              size: Size.square(9),
              activeSize: Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9))),
        )
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPage.floor()) {
      var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPage.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPage - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPage.floor() - 1) {
      var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    final Dish dish = dishes[index];

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () async {
          final updatedDish = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DishPage(dish: dish)),
          );

          if (updatedDish != null) {
            setState(() {
              dishes[index] = updatedDish;
            });
          }
        },
        child: Stack(
          children: [
            Container(
                height: Dimension.pageViewContainer,
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: index.isEven ? primaryColor : thirdColor,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(dish.urlImg)),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                  height: Dimension.pageViewTextContainer + 20,
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            offset: Offset(0, 5))
                      ]),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Flexible(
                          child: Text(
                            dish.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(5, (index) {
                                return Icon(Icons.star,
                                    color: fourthColor, size: 15);
                              }),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SmallText(text: '4.5'),
                            SizedBox(
                              width: 10,
                            ),
                            SmallText(text: '123'),
                            SizedBox(
                              width: 10,
                            ),
                            SmallText(text: 'comments'),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconText(
                                icon: Icons.circle_sharp,
                                text: 'Normal',
                                color: fourthColor,
                                iconColor: primaryColor),
                            SizedBox(
                              width: 10,
                            ),
                            IconText(
                                icon: Icons.access_time_rounded,
                                text: dish.timePrep,
                                color: primaryColor,
                                iconColor: primaryColor),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
