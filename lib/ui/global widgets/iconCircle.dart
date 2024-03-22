import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconCircle extends StatelessWidget {
  //const IconCircle({Key? key}) : super(key: key);
  String? image;
  double? height;
  double? width;
  Color? backgroundColor;
  double? parentHeight;
  double? parentWidth;
  Color? parentBackgroundColor;
  double? borderWidth;
  Color? borderColor;
  void Function()? onTap;

  IconCircle({
    required this.height,
    required this.width,
    required this.image,
    required this.backgroundColor,
    required this.parentHeight,
    required this.parentWidth,
    required this.parentBackgroundColor,
    required this.borderWidth,
    required this.borderColor,
    required this.onTap
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: parentHeight,
        width: parentWidth,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: parentBackgroundColor,
          border: Border.all(width: borderWidth!, color: borderColor!)
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle
          ),
          child: SvgPicture.asset(image!),
        ),
      ),
    );
  }
}
