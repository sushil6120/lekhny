import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class DynamicSize{
  Size getSize(GlobalKey pageKey);
}

class DynamicSizeImpl extends DynamicSize{
  @override
  Size getSize(GlobalKey<State<StatefulWidget>> pageKey) {
    RenderBox _pageBox = pageKey.currentContext!.findRenderObject() as RenderBox;
    return _pageBox.size;

  }

}