import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';

class HeadingRowWidget extends StatelessWidget {
  //const HeadingRowWidget({Key? key}) : super(key: key);
  final String? headingText;
  final String? textButton;
  final bool? showTextButton;
  final Function()? onTap;

  const HeadingRowWidget({
    required this.headingText,
    required this.textButton,
    required this.showTextButton,
    required this.onTap

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(headingText!,
            style: Theme.of(context).textTheme.headline6,

          ),
          (showTextButton==true)?
          GestureDetector(
            onTap: onTap,
            child: Text(textButton!,
                style: Theme.of(context).textTheme.button!.copyWith(
                    color: primaryColor,
                    fontSize: 12,
                    letterSpacing: 0
                )
            ),
          ):Container(),
        ],
      ),
    );
  }
}
