import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/utils/valueConstants.dart';
class Utils {

  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context, IconData icon, Color color){
    showFlushbar(
        context: context,
        flushbar : Flushbar(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18.5),
          shouldIconPulse: false,
          icon: Icon(icon,
            color: color,

          ),
          isDismissible: true,
          message : message,
          duration: Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context)
    );
  }

  static void flushBarErrorMessageWithButton(String message, BuildContext context,buttonText, void Function(Flushbar<dynamic>)? onTap){
    showFlushbar(
        context: context,
        flushbar : Flushbar(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18.5),
          shouldIconPulse: false,
          icon: Icon(Icons.error_outline_rounded,
            color: colorLightWhite,

          ),
          mainButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15,),
            child: Text("${buttonText}",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: colorLightWhite,
                decoration: TextDecoration.underline,
                decorationColor: primaryColor
              ),
            ),
          ),
          onTap: onTap,
          isDismissible: true,
          message : message,
          duration: Duration(seconds: 20),
          flushbarPosition: FlushbarPosition.BOTTOM,
        )..show(context)
    );
  }

  static void flushBarErrorMessageBottom(String message, BuildContext context){
    showFlushbar(
        context: context,
        flushbar : Flushbar(
          backgroundColor: primaryColor,
          messageColor: colorLightWhite,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 65),
          borderRadius: BorderRadius.circular(radiusValue),
          shouldIconPulse: false,
          isDismissible: true,
          message : message,
          duration: Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
        )..show(context)
    );
  }

  static snackBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message,
              style: TextStyle(
                color: colorLightWhite
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusValue))),
            backgroundColor: primaryColor,
        )

    );
  }

  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);

  }
}