import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/utils/valueConstants.dart';

class RedeemPointsOptionWidget extends StatelessWidget {
  double? height;
  double? width;
  void Function()? onTap;
  Color? borderColor;
  IconData? icon;
  Color? iconColor;
  String? text;
  Color? textColor;
  Color? boxColor;

  RedeemPointsOptionWidget({
    this.height,
    this.width,
    this.borderColor,
    this.onTap,
    this.text,
    this.iconColor,
    this.icon,
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
            Icon(icon,
              color: iconColor,
            ),
            SizedBox(height: verticalSpaceExtraSmall),
            Text(text!,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: textColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
