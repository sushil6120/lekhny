import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../../utils/images.dart';
import '../../utils/utilsFunction.dart';
import '../../viewModel/searchScreenViewModel.dart';
import '../global widgets/appBarBackButton.dart';

class CommentReplyScreen extends StatefulWidget {
  Map<String,dynamic>? arguments;
  CommentReplyScreen(this.arguments, {super.key});

  @override
  State<CommentReplyScreen> createState() => _CommentReplyScreenState();
}

class _CommentReplyScreenState extends State<CommentReplyScreen> {

  final ScrollController scrollController = ScrollController();
  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();
  int page = 1;
  String? id;
  String? token;
  String? image;

  var headers;
  var data;
  String? bucketName;
  String? poolId;

  String? commentId;
  String? pic;
  String? name;
  String? url;
  String? time;
  String? likes;
  String? replies;

  @override
  void initState() {

    commentId = widget.arguments!["commentId"];
    pic = widget.arguments!["pic"];
    name = widget.arguments!["name"];
    url = widget.arguments!["url"];
    time = widget.arguments!["time"];
    likes = widget.arguments!["likes"];
    replies = widget.arguments!["replies"];

    //final commentReplyViewModel = Provider.of<CommentReplyViewModel>(context, listen: false);

    //commentReplyViewModel.commentReplyList= [];

    // Future.wait([
    //   sharedPreferencesViewModel.getID(),
    //   sharedPreferencesViewModel.getToken(),
    //   sharedPreferencesViewModel.getImage(),
    //   sharedPreferencesViewModel.getBucketName(),
    //   sharedPreferencesViewModel.getPoolId(),
    // ]).then((value) {
    //   id = value[0];
    //   token = value[1];
    //   image = value[2];
    //   bucketName = value[3];
    //   poolId = value[4];
    //
    //   if (kDebugMode) {
    //     print("this is $id");
    //   }
    //
    //   headers = {
    //     'Content-Type': 'application/json',
    //     'Authorization': "Bearer $token"
    //   };
    //
    //   var data2 = {
    //     "APP_KEY": "SpTka6TdghfvhdwrTsXl28P1",
    //     "COMMENT_ID":  commentId
    //
    //   };
    //
    //   data = json.encode(data2);
    //   //commentReplyViewModel.getCommentReplyList(data, headers, page, 10, false);
    //
    // });

    super.initState();
  }

  @override

  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: Theme.of(context).brightness,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Theme.of(context).brightness
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            titleSpacing: 0,
            centerTitle: false,
            elevation: 0.5,
            leading: AppBarBackButton(),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text('Replies',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: 35,
                    width: 35,
                    imageUrl: "https://i.pinimg.com/originals/0a/53/c3/0a53c3bbe2f56a1ddac34ea04a26be98.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: context.deviceWidth-80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sammer Reddy",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context).textTheme.titleSmall!.color,
                            ),
                          ),
                          Text("4 hours ago",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                          width: 210,
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                            child: Text("This is is a long comment that every one should read atleast once in their lifetime.",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).textTheme.titleSmall!.color,
                              ),
                            ),
                          )
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text("1 replies",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 25),
                          Text("20 Likes",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: verticalSpaceSmall),
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 10 ,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 0.1,
                              color: Theme.of(context).disabledColor,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            if (1 > 0){
                              return Padding(
                                padding: EdgeInsets.only(left: 0, right: 0, top: 15, bottom: (index == 9)?85: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                      child: CachedNetworkImage(
                                        height: 35,
                                        width: 35,
                                        imageUrl: "https://i.pinimg.com/originals/0a/53/c3/0a53c3bbe2f56a1ddac34ea04a26be98.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    SizedBox(
                                      width: context.deviceWidth-130,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Sammer Reddy",
                                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                  color: Theme.of(context).textTheme.titleSmall!.color,
                                                ),
                                              ),
                                              Text("3 hours ago",
                                                style: Theme.of(context).textTheme.bodySmall,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                              width: 210,
                                              decoration:  BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                                child: Text((index == 0)?"This is is a long comment that every one should read atleast once in their lifetime.": "Nice",
                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                    color: Theme.of(context).textTheme.titleSmall!.color,
                                                  ),
                                                ),
                                              )
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap:(){
                                                  // Navigator.pushNamed(context, RoutesName.nestedCommentScreen,
                                                  //     arguments: {
                                                  //       "commentId" : value.postCommentList[index].commentId.toString(),
                                                  //       "name" : value.postCommentList[index].username.toString(),
                                                  //       "pic" : value.postCommentList[index].profilePic.toString(),
                                                  //       "url" :  value.postCommentList[index].comment.toString(),
                                                  //       "time" : value.postCommentList[index].commentTime.toString(),
                                                  //       "likes" : value.postCommentList[index].commentLikes.toString(),
                                                  //       "replies" : value.postCommentList[index].commentReplies.toString(),
                                                  //
                                                  //     });
                                                },
                                                child: Text("View 30 replies",
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                              ),

                                              InkWell(
                                                onTap:(){
                                                  // Navigator.pushNamed(context, RoutesName.nestedCommentScreen,
                                                  //     arguments: {
                                                  //       "commentId" : value.postCommentList[index].commentId.toString(),
                                                  //       "name" : value.postCommentList[index].username.toString(),
                                                  //       "pic" : value.postCommentList[index].profilePic.toString(),
                                                  //       "url" :  value.postCommentList[index].comment.toString(),
                                                  //       "time" : value.postCommentList[index].commentTime.toString(),
                                                  //       "likes" : value.postCommentList[index].commentLikes.toString(),
                                                  //       "replies" : value.postCommentList[index].commentReplies.toString(),
                                                  //
                                                  //     });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                                  child: Text("Edit",
                                                    style: Theme.of(context).textTheme.bodySmall,
                                                  ),
                                                ),
                                              ),

                                              InkWell(
                                                onTap:(){
                                                  // Navigator.pushNamed(context, RoutesName.nestedCommentScreen,
                                                  //     arguments: {
                                                  //       "commentId" : value.postCommentList[index].commentId.toString(),
                                                  //       "name" : value.postCommentList[index].username.toString(),
                                                  //       "pic" : value.postCommentList[index].profilePic.toString(),
                                                  //       "url" :  value.postCommentList[index].comment.toString(),
                                                  //       "time" : value.postCommentList[index].commentTime.toString(),
                                                  //       "likes" : value.postCommentList[index].commentLikes.toString(),
                                                  //       "replies" : value.postCommentList[index].commentReplies.toString(),
                                                  //
                                                  //     });
                                                },
                                                child: Text("Delete",
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }else{
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.all(35),
                                  child: CupertinoActivityIndicator(
                                      color: primaryColor
                                  ),
                                ),
                              );
                            }

                          },
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 70,
            color: Theme.of(context).canvasColor,
            padding: const EdgeInsets.only(left: 15, right: 15),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: (1 > 0)?CachedNetworkImage(
                    height: 35,
                    width: 35,
                    imageUrl: "https://i.pinimg.com/originals/0a/53/c3/0a53c3bbe2f56a1ddac34ea04a26be98.jpg",
                    fit: BoxFit.cover,
                  ):
                  CircleAvatar(
                    child: SvgPicture.asset(
                      blankProfilePicture,
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                      color: Theme.of(context).textTheme.bodyLarge!.color,

                    ),
                  ),
                ),

                // Text("Reply",
                //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //     color: Theme.of(context).textTheme.titleSmall!.color,
                //   ),
                // ),
                // Text(" (comment)",
                //   style: Theme.of(context).textTheme.bodyMedium,
                // ),

                SizedBox(
                  width: context.deviceWidth - 130,
                  child: TextFormField(
                    onChanged: (textFieldValue){
                      // value.setTextFieldLength(textFieldValue);
                      // var data = {
                      //   'searchKey': textFieldValue.toString()
                      // };
                      // value.getMainSearchData(data, headers);
                    },
                    //controller: searchController,
                    autofocus: true,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).textTheme.titleSmall!.color,
                    ),
                    decoration: InputDecoration(
                      hintText: "Reply...",
                      hintStyle: TextStyle(
                          color: Theme.of(context).textSelectionTheme.selectionColor
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),

                Icon(Icons.send)
              ],
            ),
          ),
        ),
      ),
    );
  }
}





