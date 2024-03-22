import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';

class BookStatsWidget extends StatelessWidget {
  //const BookStatsWidget({Key? key}) : super(key: key);

  final String? lightText;
  final IconData? icon;
  final double? iconSize;
  final double? fontSize;
  final Color? iconColor;

  const BookStatsWidget({
    required this.lightText,
    required this.icon,
    required this.iconSize,
    required this.fontSize,
    required this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       Icon(icon,
         size: iconSize,
         color: iconColor,


       ),
        SizedBox(width: 5),
        Text(lightText!,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontSize: fontSize
          )
        ),
      ],
    );
  }
}
