import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lekhny/styles/responsive.dart';

abstract class SplittedText{
  List<String> getSplittedText(TextStyle textStyle, String text, BuildContext context);
}

class SplittedTextImpl extends SplittedText{
  @override
  List<String> getSplittedText(TextStyle textStyle, String text, BuildContext context) {
    final List<String> _pageTexts =[];
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(
      minWidth: 0,
      // maxWidth: pageSize.width,
      maxWidth: context.deviceWidth-30,
    );
    List<LineMetrics> lines = textPainter.computeLineMetrics();
    double currentPageBottom = context.deviceHeight-context.safeAreaHeight*3.4;
    int currentPageStartIndex= 0;
    int currentPageEndIndex =  0;

    for(int i=0;i<lines.length; i++){
      final line = lines[i];

      final left= line.left;
      final top = line.baseline - line.ascent;

      final bottom = line.baseline + line.descent;
      ////current line overflow;

      if (currentPageBottom < bottom){
        currentPageEndIndex = textPainter.getPositionForOffset(Offset(left,top)).offset;

        final pageText = text.substring(currentPageStartIndex, currentPageEndIndex)??"";
        _pageTexts.add(pageText);

        currentPageStartIndex = currentPageEndIndex;
        currentPageBottom = top + (context.deviceHeight-context.safeAreaHeight*3.9);
      }
    }

    final lastPageText = text.substring(currentPageStartIndex)??"";
    _pageTexts.add(lastPageText);
    return _pageTexts;

  }
}
//-(context.safeAreaHeight + 30 + context.deviceHeight*0.32)

