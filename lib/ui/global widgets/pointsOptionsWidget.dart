import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/utils/valueConstants.dart';

class PointsOptionsWidget extends StatelessWidget {
  String? headingText;
  String? captionText;
  double? captionTextWidth;
  IconData? prefixIcon;
  Color? prefixIconColor;
  double? prefixIconsSize;
  IconData? sufixIcon;
  Color? sufixIconColor;
  double? sufixIconsSize;
  void Function()? onTap;

  PointsOptionsWidget({
    this.captionTextWidth,
    this.sufixIconColor,
    this.sufixIconsSize,
    this.sufixIcon,
    this.captionText,
    this.headingText,
    this.onTap,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixIconsSize
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
            Icon(sufixIcon,
              size: sufixIconsSize,
              color: sufixIconColor,
            ),
          ],
        ),
      ),
    );
  }
}
