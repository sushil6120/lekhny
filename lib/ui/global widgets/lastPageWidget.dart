import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/postLikesListModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/bookStatsWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/readingScreenViewModel.dart';
import 'package:provider/provider.dart';

class LastPageWidget extends StatefulWidget {
  int? currentChapterIndex;
  SingleBookDetailsModelClass? singleBookDetailsModel;
  SingleBookPartsModelClass? singleBookPartsModel;
  PostLikesListModelClass? postLikesListModelClass;
  var headers;
  String? postId;

  LastPageWidget({
    this.singleBookDetailsModel,
    this.currentChapterIndex,
    this.singleBookPartsModel,
    this.postLikesListModelClass,
    this.postId,
    this.headers
  });


  @override
  State<LastPageWidget> createState() => _LastPageWidgetState();
}

class _LastPageWidgetState extends State<LastPageWidget> {

  String? imageBaseUrl;
  //const LastPageWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("this is parts length ${widget.singleBookPartsModel!.data!.length}");
    print("this is curremtChapterIndex ${widget.currentChapterIndex}");
    imageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;

    if(widget.singleBookDetailsModel!.data![0].languageID != null){
      imageBaseUrl = (widget.singleBookDetailsModel!.data![0].languageID == "3")?AppUrl.englishImagebaseUrl:
      (widget.singleBookDetailsModel!.data![0].languageID == "2")?AppUrl.hindiImagebaseUrl:(widget.singleBookDetailsModel!.data![0].languageID == "4")?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;

    }
    return SizedBox(
      height: context.deviceHeight- (context.safeAreaHeight*2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: verticalSpaceMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Share',
                          style: Theme.of(context).textTheme.bodyText1
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.share_outlined,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 100),
              Container(
                width: 145,
                height: 215,
                margin: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  //color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(2.5, 6)
                      )
                    ]
                ),
                child: AspectRatio(
                  aspectRatio: 1 /1.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                    child: CachedNetworkImage(
                      imageUrl: "${imageBaseUrl}${widget.singleBookDetailsModel!.data![0].bookCover}",
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              SizedBox(height: verticalSpaceSmall),
              Text("${widget.singleBookDetailsModel!.data![0].title}",
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text("${widget.singleBookDetailsModel!.data![0].author}",
                  style: Theme.of(context).textTheme.bodyText2
              ),
              SizedBox(height: verticalSpaceSmall),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children : [
                        BookStatsWidget(
                          icon: Icons.remove_red_eye_outlined,
                          iconSize: 16,
                          lightText: "${widget.singleBookDetailsModel!.data![0].views} Views",
                          iconColor: primaryColor,
                          fontSize: 14,
                        ),
                        Container(
                          height: 35,
                          width: 0.5,
                          color: Theme.of(context).disabledColor,
                        ),
                        Consumer<ReadingScreenViewModel>(
                            builder: (context,value,child){
                              return InkWell(
                                onTap: (){
                                  value.likePostData(widget.postId!, null, widget.headers);
                                },
                                child: BookStatsWidget(
                                  icon: (value.isLiked == 0)?Icons.favorite_border_rounded:Icons.favorite,
                                  iconSize: 16,
                                  lightText: "${value.likeValue} Likes",
                                  iconColor: errorColor,
                                  fontSize: 14,
                                ),
                              );

                            }
                        ),

                        Container(
                          height: 35,
                          width: 0.5,
                          color: Theme.of(context).disabledColor,
                        ),
                        InkWell(
                          onTap: (){
                              Navigator.pushNamed(context, RoutesName.commentScreen,
                                  arguments: {
                                    "postId" : widget.postId,
                                  });
                          },
                          child: BookStatsWidget(
                            icon: Icons.mode_comment_outlined,
                            iconSize: 16,
                            lightText: 'Comments',
                            iconColor: primaryColor,
                            fontSize: 14,
                          ),
                        ),

                      ]
                  )
              ),
              SizedBox(height: verticalSpaceSmall),

            ],
          ),
          (widget.singleBookPartsModel!.data!.length > widget.currentChapterIndex!+1)?
          Padding(
            padding: EdgeInsets.only(bottom: verticalSpaceMedium),
            child: ButtonBig(
              onTap: (){
                Navigator.pushReplacementNamed(context, RoutesName.readingScreen,
                    arguments: {"postId" : widget.singleBookPartsModel!.data![widget.currentChapterIndex!+1].id, "index" : widget.currentChapterIndex!+1}
                );
              },
              height: 40,
              width: 150,
              backgroundColor: Theme.of(context).primaryColor,
              text: 'Next Chapter',
              showProgress: false,
              radius: radiusValue,
              fontSize: 14,
              letterspacing: 0.2,
              textPadding: 0,

            ),
          ):
          Padding(
            padding: EdgeInsets.only(bottom: verticalSpaceMedium),
            child: Text('',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                fontSize: 30,
                color: Theme.of(context).disabledColor
              )
            ),
          )



        ],
      ),
    );
  }
}
