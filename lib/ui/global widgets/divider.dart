import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  //const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.1,
      color: Theme.of(context).textTheme.bodyText1!.color,
    );
  }
}
