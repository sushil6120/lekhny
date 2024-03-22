import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/utils/valueConstants.dart';

class LanguageOptionWidget extends StatelessWidget {
  double? height;
  double? width;
  void Function()? onTap;
  Color? borderColor;
  String? languageText;
  Color? languageTextColor;
  String? text;
  Color? textColor;
  Color? boxColor;

  LanguageOptionWidget({
    this.height,
    this.width,
    this.borderColor,
    this.onTap,
    this.text,
    this.languageText,
    this.languageTextColor,
    this.boxColor,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: boxColor,
            border: Border.all(width: 1, color: borderColor!),
            borderRadius: BorderRadius.all(Radius.circular(radiusValue))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(languageText!,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: languageTextColor
              ),
            ),
            SizedBox(height: verticalSpaceExtraSmall),
            Text(text!,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: textColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
