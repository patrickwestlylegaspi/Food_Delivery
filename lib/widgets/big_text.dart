import 'package:flutter/material.dart';
import 'package:food_delivery/config/dimension.dart';

class BigText extends StatelessWidget {
  BigText({
    super.key,
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.overFlow = TextOverflow.ellipsis,
    this.size = 0,
  });

  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size==0?Dimensions.font20:size,
      ),
    );
  }
}
