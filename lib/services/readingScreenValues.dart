import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lekhny/utils/dynamicSize.dart';
import 'package:lekhny/utils/splittedText.dart';


class ReadingScreenValues{

  DynamicSize _dynamicSize = DynamicSizeImpl();
  SplittedText _splittedText = SplittedTextImpl();
  Size? _size;

  List<String> _splittedTextList = [];
  List<String>  get splittedTextList => _splittedTextList;


  getSizeValue(GlobalKey pagekey){
    _size = _dynamicSize.getSize(pagekey);

  }

  getSplittedTextValue(TextStyle textStyle,String? text, BuildContext context){
    _splittedTextList= _splittedText.getSplittedText(textStyle, text!, context);
  }


}
