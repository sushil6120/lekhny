import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/ui/global%20widgets/circularProgressWidget.dart';

//import 'circularProgressWidget.dart';

class ButtonBig extends StatelessWidget {
  //const ({Key? key}) : super(key: key);
  double? height;
  double? width;
  bool? showProgress;
  String? text;
  Color? backgroundColor;
  double? radius;
  double? fontSize;
  Color? textColor;
  Color? progressColor;
  double? letterspacing;
  double? progressStrokeWidth;
  void Function()? onTap;
  double? textPadding;

  ButtonBig({
    required this.height,
    this.width,
    required this.backgroundColor,
    required this.text,
    required this.showProgress,
    required this.radius,
    this.fontSize,
    this.textColor,
    this.letterspacing,
    this.progressStrokeWidth,
    this.progressColor,
    this.onTap,
    this.textPadding
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(radius!)),
        ),
        child: (showProgress==true)?Center(child: AspectRatio(
          aspectRatio: 1/1,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: CircularProgressWidget(
              color: progressColor,
              strokeWidth: progressStrokeWidth,
            ),
          ),
        )):
        Center(child:
        Padding(
          padding: EdgeInsets.symmetric(horizontal: textPadding!),
          child: Text(text!,
            style: Theme.of(context).textTheme.button!.copyWith(
              fontSize: fontSize,
              color: textColor,
              letterSpacing: letterspacing
            )
          ),
        )) ,
      ),
    );
  }
}

