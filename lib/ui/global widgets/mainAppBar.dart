import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appBarBackButton.dart';

AppBar MainappBarWidget(){
  return AppBar(
    titleSpacing: 0,
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: AppBarBackButton(),
  );
}

