import 'package:flutter/material.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/utils/valueConstants.dart';

class BookListContainer extends StatelessWidget {
  //const BookListContainer({Key? key}) : super(key: key);
  final double? listViewHeight;
  final Widget? child;
  final Widget? headingWidget;

  const BookListContainer({
    required this.listViewHeight,
    required this.headingWidget,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceWidth,
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      margin: EdgeInsets.only(top: verticalSpaceSmall),
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headingWidget!,
          SizedBox(height: verticalSpaceSmall),
          SizedBox(
            height: listViewHeight,
            child: child,
          )
        ],
      ),
    );
  }
}
