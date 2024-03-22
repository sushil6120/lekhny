import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/responsive.dart';
import 'appBarBackButton.dart';

class AppBarWidget extends StatelessWidget {
  //const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.appBarHeight,
      alignment: Alignment.centerLeft,
      child: AppBarBackButton(),
    );
  }
}

