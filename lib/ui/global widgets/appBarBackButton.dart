import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';

class AppBarBackButton extends StatelessWidget {
  //const AppBarBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back_ios_new_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
