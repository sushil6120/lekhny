import 'package:flutter/cupertino.dart';

class IosProgressIndicatorWidget extends StatelessWidget {

  AlignmentGeometry? alignment;
  double? paddingTop;
  Color? color;

  IosProgressIndicatorWidget(
      this.alignment,
      this.paddingTop,
      this.color,

      );


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment!,
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop!),
        child: CupertinoActivityIndicator(
            color: color
        ),
      ),
    );
  }
}
