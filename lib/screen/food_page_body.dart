import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/config/app_colors.dart';

import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/config/dimension.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Dimensions.pageView,
          child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        DotsIndicator(
          dotsCount: 5,
          position: _currentPageValue.toInt(),
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 3,
                ),
                child: BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Food pairing",
                ),
              )
            ],
          ),
        ),
        Container(
          height: 700,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white38,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/8/88/Philippine_Food.jpg"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(
                                Dimensions.radius20,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10,
                            ),
                            child: Column(
                              children: [
                                BigText(text: "Nutritious food in philippines"),
                                SmallText(text: "text")
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven
                  ? const Color(0xFF69c5df)
                  : const Color(0xFF9294cc),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/8/88/Philippine_Food.jpg"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(5, 0),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: "Filipino Cuisine"),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                color: AppColors.mainColor,
                                size: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SmallText(text: "4.5"),
                          const SizedBox(
                            width: 10,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SmallText(text: "Comments"),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: "Normal",
                            iconColor: AppColors.iconColor1,
                          ),
                          IconAndTextWidget(
                              icon: Icons.location_on,
                              text: "32 km",
                              iconColor: AppColors.iconColor1),
                          IconAndTextWidget(
                            icon: Icons.access_alarm_rounded,
                            text: "20 mins",
                            iconColor: AppColors.iconColor1,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
