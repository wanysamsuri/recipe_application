import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  SmallText(
      {Key? key,
      this.color,
      required this.text,
      this.size = 20,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
    );
  }
}
