import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/utils/valueConstants.dart';

class OtpWidget extends StatelessWidget {

  bool? first;
  bool? last;
  TextEditingController? inputController;
  Color? borderColor;
  OtpWidget({this.first, this.last, this.inputController, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: TextField(
        controller: inputController,
        //autofocus: true,
        onChanged: (value){
          if(value.length== 1 && last== false){
            FocusScope.of(context).nextFocus();
          }
          if(value.length== 0 && first== false){
            FocusScope.of(context).previousFocus();
          }
        },
        cursorColor: Colors.black,
        showCursor: true,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
            isDense: false,
            contentPadding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 0.0 ,
            ),
            counterText: '',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor!,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(radiusValue))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor!,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(radiusValue))
            )
        ),
      ),
    );
  }
}
