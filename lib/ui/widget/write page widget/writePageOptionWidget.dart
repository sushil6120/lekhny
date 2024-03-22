import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/utils/valueConstants.dart';

class WritePageOptionWidget extends StatelessWidget {
  //const ({Key? key}) : super(key: key);
  IconData? icon;
  Color? iconColor;
  double? iconsSize;
  String? text;
  void Function()? onTap;

  WritePageOptionWidget({
    required this.onTap,
    required this.icon,
    required this.iconColor,
    required this.iconsSize,
    required this.text,
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
          children: [
            Icon(icon,
              size: iconsSize,
              color: iconColor,
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.deviceWidth - 100,
                  child: Text(text!,
                    style: Theme.of(context).textTheme.subtitle2,
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
      ),
    );
  }
}
