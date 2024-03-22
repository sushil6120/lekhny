import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/valueConstants.dart';

class SearchTextFormFieldBig extends StatelessWidget {
  //const SearchTextFormFieldBig({Key? key}) : super(key: key);
  double? height;
  String? hintText;
  Icon? prefixIcon;
  Icon? suffixIcon;
  String Function(String?)? validator;
  TextEditingController? controller;
  void Function()? onTap;


  SearchTextFormFieldBig({
    required this.hintText,
    required this.height,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextFormField(
        onTap: onTap,
        readOnly: true,
        controller: controller,
        expands: true,
        maxLines: null,
        minLines: null,
        style:Theme.of(context).textTheme.caption!.copyWith(
          color: Theme.of(context).textTheme.headline4!.color!
        ),
        validator: validator,
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorStyle: TextStyle(
                color: colorLight3,
                fontSize: 12
            ),
            hintText: hintText,
            hintStyle: TextStyle(
                color: Theme.of(context).textSelectionTheme.selectionColor
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            focusedErrorBorder:OutlineInputBorder(
                borderSide: BorderSide(width: 1,color: Theme.of(context).disabledColor),
                borderRadius: BorderRadius.all(Radius.circular(radiusValue))
            )  ,
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1,color: Theme.of(context).disabledColor),
                borderRadius: BorderRadius.all(Radius.circular(radiusValue))
            ) ,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1,color: Theme.of(context).disabledColor),
                borderRadius: BorderRadius.all(Radius.circular(radiusValue))
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1,color: Theme.of(context).disabledColor),
                borderRadius: BorderRadius.all(Radius.circular(radiusValue))
            )
        ),
      ),
    );
  }
}
