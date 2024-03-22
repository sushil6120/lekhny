import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/utils/valueConstants.dart';

class TextFieldLabelTextWidget extends StatelessWidget {
  String? labelText;
  TextFieldLabelTextWidget({this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: verticalSpaceSmall, bottom: verticalSpaceExtraSmall),
      child: Text(labelText!,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
