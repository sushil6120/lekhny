import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/valueConstants.dart';

class BookWidget extends StatelessWidget {
  //const BookWidget({Key? key}) : super(key: key);
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
  final CrossAxisAlignment? crossAxisAlignment;
  final void Function()? onTap;

  const BookWidget({
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
    required this.crossAxisAlignment,
    required this.onTap
});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment!,
      children: [
        (showParts==true)?
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.library_books_outlined,
                size: 14,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 2),
              Text('$partsValue PARTS',
                style: Theme.of(context).textTheme.overline!.copyWith(
                    letterSpacing: 0.1,
                    color: Theme.of(context).textTheme.bodyText1!.color!

                ),
              ),
            ],
          ),
        ):Container(),
        SizedBox(height: partsSpace),
        GestureDetector(
          onTap: onTap,
          child: Container(
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
                child: CachedNetworkImage(
                  placeholder: (context, string){
                    return Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor
                        ),
                        child: Image.asset(lekhnyLogoEnglish)
                    );
                  },
                  fadeOutDuration: Duration(seconds: 0),
                  imageUrl: "$imgUrl",
                  fit: BoxFit.fill,
                  alignment: Alignment.bottomCenter,
                  errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                            children: [
                              Image.asset(lekhnyLogoEnglish),
                              const SizedBox(height: 5),
                              Text('$bookName',
                                style: Theme.of(context).textTheme.overline!.copyWith(
                                    letterSpacing: 0,
                                    color: Theme.of(context).textTheme.subtitle1!.color!

                                ),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                            ),
                            Text('By $writerName',
                              style: Theme.of(context).textTheme.overline!.copyWith(
                                  letterSpacing: 0,
                                  fontSize: 8,
                                  color: Theme.of(context).textTheme.bodyText1!.color!

                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),

                          ],
                        ),
                      )
                  )
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: imgSpace),
        (showViews==true)?
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.remove_red_eye_outlined,
                size: 12,
                color: primaryColor,
              ),
              const SizedBox(width: 2),
              Text('$viewsValue',
                style: Theme.of(context).textTheme.overline!.copyWith(
                    letterSpacing: 0.5
                ),
              ),
            ],
          ),
        ):Container(),
        (showBookTitle==true)?
        SizedBox(
          width: bookTextWidth,
          child: Text('$bookName',
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.start,
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.clip,
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
    );
  }
}
