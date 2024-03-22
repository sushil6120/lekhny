import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';

class CircularProgressWidget extends StatelessWidget {
  //const CircularProgressIndicator({Key? key}) : super(key: key);
  Color? color;
  double? strokeWidth;
  CircularProgressWidget({required this.color, required this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color,
      strokeWidth: strokeWidth!,
    );
  }
}
