import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtomWidget extends StatelessWidget {
  //const ChangeThemeButtomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Switch.adaptive(
        activeColor: darkModeHighlightColor,
        //activeTrackColor: darkModeHighlightColor,
        inactiveThumbColor: colorLight3,
        inactiveTrackColor: colorLight2,
        //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: themeManager.isDarkMode,
        onChanged: (value){
          final themeManager = Provider.of<ThemeManager>(context, listen: false);
          themeManager.toggleTheme(value);
        });
  }
}
