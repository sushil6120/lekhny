import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/valueConstants.dart';

class BookListBuilder extends ListView {
  final int? itemCount;
  final double? margin;

  final bool? showParts;
  final bool? showViews;
  final bool? showBookTitle;
  final bool? showWriter;
  final String? partsValue;
  final double? partsSpace;
  final double? imgSpace;
  final double? imageHeight;
  final double? imageWidth;
  final String? imgUrl;
  final String? viewsValue;
  final double? bookTextWidth;
  final String? bookName;
  final double? bookNameSpace;
  final double? writerTextWidth;
  final String? writerName;

  BookListBuilder({
    required this.itemCount,
    required this.margin,

    required this.showParts,
    required this.showViews,
    required this.showBookTitle,
    required this.showWriter,
    required this.partsValue,
    required this.partsSpace,
    required this.imgSpace,
    required this.imageHeight,
    required this.imageWidth,
    required this.imgUrl,
    required this.viewsValue,
    required this.bookTextWidth,
    required this.bookName,
    required this.bookNameSpace,
    required this.writerTextWidth,
    required this.writerName,
});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: (context.locale == Locale('ur'))?
          (index== 0)?EdgeInsets.only(left: margin!, right: margin!):EdgeInsets.only(left: margin!):
          (index==0)?EdgeInsets.only(left: margin!, right: margin!):EdgeInsets.only(right: margin!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (showParts==true)?
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.bookmark_border_rounded,
                    size: 14,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 2),
                  Text('$partsValue PARTS',
                    style: Theme.of(context).textTheme.overline!.copyWith(
                        letterSpacing: 0.1,
                        color: Theme.of(context).textTheme.bodyText1!.color!

                    ),
                  ),
                ],
              ):Container(),
              SizedBox(height: partsSpace),
              Container(
                width: imageHeight,
                height: imageWidth,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                ),
                child: AspectRatio(
                  aspectRatio: 1 /1.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                    child: Image.network("$imgUrl",
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              SizedBox(height: imgSpace),
              (showViews==true)?
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.remove_red_eye_outlined,
                    size: 12,
                    color: secondaryColor,
                  ),
                  SizedBox(width: 2),
                  Text('$viewsValue',
                    style: Theme.of(context).textTheme.overline!.copyWith(
                        letterSpacing: 0.5
                    ),
                  ),
                ],
              ):Container(),
              (showBookTitle==true)?
              SizedBox(
                width: bookTextWidth,
                child: Text('$bookName',
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.start,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ):Container(),
              SizedBox(height: bookNameSpace),
              (showWriter==true)?
              SizedBox(
                width: writerTextWidth,
                child: Text('$writerName',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.start,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ):Container(),
              //SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
