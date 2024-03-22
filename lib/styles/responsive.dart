import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get safeAreaHeight => MediaQuery.of(this).padding.top;
  double get appBarHeight => AppBar().preferredSize.height;
  double get actualHeight => deviceHeight-safeAreaHeight;
}
