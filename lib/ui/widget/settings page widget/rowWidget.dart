import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/valueConstants.dart';

class RowWidget extends StatelessWidget {
  //const RowWidget({Key? key}) : super(key: key);
  String? labelText;
  IconData? icons;
  void Function()? onTap;

  RowWidget({
    required this.onTap,
    required this.icons,
    required this.labelText
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: bigButtonHeight,
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(radiusValue))

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icons,
                size: 20,
              ),
              SizedBox(width: 15),
              Text(labelText!,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: Icon(Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).primaryIconTheme.color,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
