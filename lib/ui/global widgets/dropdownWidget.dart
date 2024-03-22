import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/utils/valueConstants.dart';

class DropdownWidget extends StatelessWidget {

  List<String>? items;
  String? selectedValue;
  void Function(String?)? onChanged;
  String? hint;

  DropdownWidget({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.hint
  });


  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        //underline: Divider(height: 2, color: primaryColor,),
        selectedItemHighlightColor: Theme.of(context).canvasColor,
        selectedItemBuilder: (BuildContext conetxt){
          return List.generate(
              items!.length,
                  (index){
                    return  Text('English',
                      style:Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).textTheme.headline4!.color!
                      ),
                    );
                  });
        },
        icon: Icon(Icons.arrow_drop_down_rounded,
        ),
        style: Theme.of(context).textTheme.bodyText2,
        hint: Text(hint!,
          style:Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context).disabledColor
          ),
        ),
        items: items
            !.map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: Theme.of(context).textTheme.bodyText2,
            overflow: TextOverflow.ellipsis,
          ),
        ))
            .toList(),
        value: selectedValue,
        onChanged: onChanged,
        buttonSplashColor: Colors.transparent,
        buttonHighlightColor: Colors.transparent,
        //buttonOverlayColor: MaterialStateProperty.all(Colors.transparent),
        iconSize: 24,
        iconEnabledColor: Theme.of(context).textTheme.headline4!.color!,
        // iconDisabledColor: Colors.grey,
        buttonHeight: 48,
        buttonWidth: context.deviceWidth,
        buttonPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        buttonDecoration: BoxDecoration(
          border: Border.all(width: 1,color: Theme.of(context).textTheme.headline4!.color!),
          borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
          color: Colors.transparent,
        ),
        //buttonElevation: 2,
        //itemHeight: 40,
        itemPadding: EdgeInsets.only(left: 15, right: 15),
        dropdownMaxHeight: 400,
        dropdownWidth: context.deviceWidth-36,
        //dropdownPadding: EdgeInsets.only(left: 18, right: 18),
        dropdownDecoration: BoxDecoration(
          // border: Border(
          //   bottom: BorderSide(width: 1, color: Theme.of(context).primaryIconTheme.color! ),
          // ),
          borderRadius: BorderRadius.circular(radiusValue),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        dropdownElevation: 1,
        //scrollbarRadius: const Radius.circular(40),
        //scrollbarThickness: 6,
        //scrollbarAlwaysShow: true,
        offset: (context.locale == Locale('ur'))?Offset(0, -10):Offset(0, -10),
      ),
    );
  }
}

// <Widget>[
//             Text('English',
//               style:Theme.of(context).textTheme.bodyText1!.copyWith(
//                   color: Theme.of(context).textTheme.headline4!.color!
//               ),
//             ),
//             Text('हिन्दी',
//               style:Theme.of(context).textTheme.bodyText1!.copyWith(
//                   color: Theme.of(context).textTheme.headline4!.color!
//               ),
//             ),
//             Text('اردو',
//               style:Theme.of(context).textTheme.bodyText1!.copyWith(
//                   color: Theme.of(context).textTheme.headline4!.color!
//               ),
//             ),
//
//           ];
