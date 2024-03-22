import 'package:flutter/cupertino.dart';

class ColoredVerticalSpace extends StatelessWidget {
  //const ColoredVerticalSpace({Key? key}) : super(key: key);
  final double? height;
  final Color? color;

  const ColoredVerticalSpace({required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ColoredBox(
        color: color!,
      ),
    );
  }
}
