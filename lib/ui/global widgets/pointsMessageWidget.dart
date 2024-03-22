import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/utils/valueConstants.dart';

class PointsMessageWidget extends StatelessWidget {
  String? headingText;
  String? captionText;
  String? suffixText;
  Color? suffixTextColor;
  double? captionTextWidth;
  IconData? prefixIcon;
  Color? prefixIconColor;
  double? prefixIconsSize;
  void Function()? onTap;

  PointsMessageWidget({
    this.captionTextWidth,
    this.captionText,
    this.headingText,
    this.onTap,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixIconsSize,
    this.suffixText,
    this.suffixTextColor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(radiusValue))
        ),
        margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        padding: EdgeInsets.only(bottom: 12, top: 12, left: 15, right: 15),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(prefixIcon,
                  size: prefixIconsSize,
                  color: prefixIconColor,
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(headingText!,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: captionTextWidth,
                      child: Text(captionText!,
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.start,
                        softWrap: false,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(suffixText!,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: suffixTextColor
              ),
              textAlign: TextAlign.start,
              softWrap: false,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )

          ],
        ),
      ),
    );
  }
}
