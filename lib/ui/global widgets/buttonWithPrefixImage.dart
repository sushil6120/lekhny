import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/ui/global%20widgets/circularProgressWidget.dart';

//import 'circularProgressWidget.dart';

class ButtonWithPrefixImage extends StatelessWidget {
  //const ({Key? key}) : super(key: key);
  double? height;
  double? width;
  bool? showProgress;
  String? text;
  Color? backgroundColor;
  double? radius;
  double? fontSize;
  Color? textColor;
  double? letterspacing;
  double? borderWidth;
  Color? borderColor;
  Color? progressColor;
  double? progressStrokeWidth;
  void Function()? onTap;
  double? imgHeight;
  double? imgWidth;
  String? img;
  double? imgSpace;

  ButtonWithPrefixImage({
    required this.height,
    required this.width,
    required this.backgroundColor,
    required this.text,
    required this.showProgress,
    required this.radius,
    this.fontSize,
    this.textColor,
    this.letterspacing,
    this.borderWidth,
    this.borderColor,
    this.progressStrokeWidth,
    this.progressColor,
    this.onTap,
    this.imgHeight,
    this.imgWidth,
    this.img,
    this.imgSpace
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
          border: Border.all(width: borderWidth!, color: borderColor!),

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
        Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: imgHeight,
                  width: imgWidth,
                  child: SvgPicture.asset(img!),
                ),
                SizedBox(width: imgSpace),
                Text(text!,
                    style: Theme.of(context).textTheme.button!.copyWith(
                        fontSize: fontSize,
                        color: textColor,
                        letterSpacing: letterspacing
                    )
                ),
              ],
            ))
      ),
    );
  }
}