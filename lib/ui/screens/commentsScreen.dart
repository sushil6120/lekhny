import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/bookListBuilder.dart';
import 'package:lekhny/ui/global%20widgets/bookListContainer.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/coloredVerticalSpace.dart';
import 'package:lekhny/ui/global%20widgets/outlineButtonBig.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/screens/topTenWritersScreen.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/searchTextFormFieldBig.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/extensions.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lekhny/viewModel/commentsViewModel.dart';
import 'package:lekhny/viewModel/commentsViewModel.dart';
import 'package:lekhny/viewModel/draftsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  Map<String,dynamic>? arguments;
  CommentsScreen(this.arguments, {super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  //const CommentsScreen({Key? key}) : super(key: key);


  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();
  TextEditingController commentController =  TextEditingController();
  TextEditingController replyController =  TextEditingController();
  TextEditingController editCommentController =  TextEditingController();
  TextEditingController editReplyController =  TextEditingController();

  FocusNode commentFocus = FocusNode();
  FocusNode replyFocus = FocusNode();
  FocusNode editCommentFocus = FocusNode();
  FocusNode editReplyFocus = FocusNode();

  bool? showReply = false;
  bool? showReplyField = false;

  int? tappedIndex;

  String? userId;
  String? profilePic;
  String? postId;
  String? appLanguage;
  String? imageBaseUrl;
  var headers;

  @override
  void initState() {

    postId = widget.arguments!["postId"];

    final commentsViewModel = Provider.of<CommentsViewModel>(context, listen: false);


    (()async{
      appLanguage = await sharedPreferencesViewModel.getLanguage();
      userId = await sharedPreferencesViewModel.getUserId();
      profilePic = await sharedPreferencesViewModel.getProfilePic();
    })().then((value){
      print('this is appLanguage ${appLanguage}');
      sharedPreferencesViewModel.getToken().then((value){
        headers = {
          'lekhnyToken': value.toString(),
          'AppLanguage': appLanguage??"3",
          'Authorization': 'Bearer ${value.toString()}'
        };

        print("this is userId $userId");

        commentsViewModel.getCommentsListData(null, headers, postId);

      });
    });
    // TODO: implement initState

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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            titleSpacing: 0,
            centerTitle: false,
            elevation: 0.5,
            leading: AppBarBackButton(),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text('Comments',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: Consumer<CommentsViewModel>(
              builder: (context,value,child){
                //print('satus ${value.homePageData.status}');
                //print('value ${value.homePageData.data![0]!.data!.length}');
                switch(value.commentsListData.status){
                  case Status.LOADING :
                    return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        )
                    );

                  case Status.ERROR :
                    return Text('${value.commentsListData.message.toString()} this is the error');

                  case Status.COMPLETED :
                    return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.commentsListModel!.data!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 0.1,
                          color: Theme.of(context).disabledColor,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: (index == value.commentsListModel!.data!.length-1)?85: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: (value.commentsListModel!.data![index].profile == null)?
                                Image.asset(blankProfilePicture, height: 35,width: 35,):
                                CachedNetworkImage(
                                  height: 35,
                                  width: 35,
                                  imageUrl: "${AppUrl.profileImagebaseUrl}${value.commentsListModel!.data![index].profile}",
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
                                        Text("${value.commentsListModel!.data![index].userName}",
                                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                            color: Theme.of(context).textTheme.titleSmall!.color,
                                          ),
                                        ),
                                        Text(DateFormat("yyyy-MM-dd hh:mm:ss").parse(value.commentsListModel!.data![index].commentOn!).timeAgo(numericDates: false),
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
                                          child: Text("${value.commentsListModel!.data![index].comments}",
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
                                            setState(() {
                                              showReply = !showReply!;
                                              tappedIndex = index;
                                            });
                                            // Navigator.pushNamed(context, RoutesName.commentReplyScreen,
                                            //     arguments: {
                                            //       "commentId" : "${value.commentsListModel!.data![index].commentID}",
                                            //
                                            //     });
                                          },
                                          child: Text("${value.commentsListModel!.data![index].commentReply!.length} ${(value.commentsListModel!.data![index].commentReply!.length > 1) ?"Replies": "Reply"} ",
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: primaryColor

                                            ),
                                          ),
                                        ),

                                        InkWell(
                                          onTap:(){

                                            setState(() {
                                              tappedIndex = index;
                                              showReplyField = !showReplyField!;
                                            });
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
                                            child: Text("Reply",
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ),
                                        ),

                                        (userId == value.commentsListModel!.data![index].commentBy.toString())?
                                        InkWell(
                                          onTap:(){
                                            editCommentController.text = value.commentsListModel!.data![index].comments.toString();
                                            _showCommentEdit(context, index);

                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Text("Edit",
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ),
                                        ):
                                        SizedBox(),

                                        (userId == value.commentsListModel!.data![index].commentBy.toString())?
                                        InkWell(
                                          onTap:(){
                                           deleteCommentDialog(context, index);
                                          },
                                          child: Text("Delete",
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                        ):
                                        SizedBox()
                                      ],
                                    ),

                                    (value.commentsListModel!.data![index].commentReply!.length > 0)?
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: ListView.separated(
                                        //controller: scrollController,
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: (tappedIndex == index)? (showReply == true)? value.commentsListModel!.data![index].commentReply!.length: 1:1  ,
                                        separatorBuilder: (BuildContext context, int index) {
                                          return Divider(
                                            height: 0.1,
                                            color: Theme.of(context).disabledColor,
                                          );
                                        },
                                        itemBuilder: (BuildContext context, int index2) {
                                          return Padding(
                                            padding: EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 15),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                  child: (value.commentsListModel!.data![index].commentReply![index2].userProfile == null)?
                                                  Image.asset(blankProfilePicture, height: 35,width: 35,):CachedNetworkImage(
                                                    height: 35,
                                                    width: 35,
                                                    imageUrl: "${value.commentsListModel!.data![index].commentReply![index2].userProfile}",
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
                                                          Text("${value.commentsListModel!.data![index].commentReply![index2].name}",
                                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                              color: Theme.of(context).textTheme.titleSmall!.color,
                                                            ),
                                                          ),
                                                          Text(DateFormat("yyyy-MM-dd hh:mm:ss").parse(value.commentsListModel!.data![index].commentReply![index2].createdAt!).timeAgo(numericDates: false),
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
                                                            child: Text("${value.commentsListModel!.data![index].commentReply![index2].reply}",
                                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                color: Theme.of(context).textTheme.titleSmall!.color,
                                                              ),
                                                            ),
                                                          )
                                                      ),
                                                      const SizedBox(height: 20),
                                                      Row(
                                                        children: [
                                                          (userId == value.commentsListModel!.data![index].commentReply![index2].replyBy.toString())?
                                                          InkWell(
                                                            onTap:(){
                                                              editReplyController.text = value.commentsListModel!.data![index].commentReply![index2].reply.toString();
                                                              _showReplyEdit(context, index, index2);
                                                            },
                                                            child: Text("Edit",
                                                              style: Theme.of(context).textTheme.bodySmall,
                                                            ),
                                                          ):
                                                          SizedBox(),

                                                          SizedBox(width: 15),

                                                          (userId == value.commentsListModel!.data![index].commentReply![index2].replyBy.toString())?
                                                          InkWell(
                                                            onTap:(){
                                                              deleteReplyDialog(context, index, index2);

                                                            },
                                                            child: Text("Delete",
                                                              style: Theme.of(context).textTheme.bodySmall,
                                                            ),
                                                          ):
                                                          SizedBox(),
                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );

                                        },
                                      ),
                                    ):
                                    SizedBox(),

                                    (tappedIndex == index)?
                                    (showReplyField == true)?

                                    Container(
                                      height: 70,

                                      alignment: Alignment.center,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                            child: (profilePic == null)?
                                              Image.asset(blankProfilePicture, height: 35,width: 35,):CachedNetworkImage(
                                              height: 35,
                                              width: 35,
                                              imageUrl: "${AppUrl.profileImagebaseUrl}$profilePic",
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error) => Image.asset(blankProfilePicture, height: 35,width: 35,),
                                            )
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
                                            width: context.deviceWidth - 195,
                                            child: TextFormField(
                                              focusNode: replyFocus,
                                              controller: replyController,
                                              autofocus: false,
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

                                          Consumer<CommentsViewModel>(
                                              builder: (context,value,child){
                                                return InkWell(
                                                    onTap: (){

                                                      if(replyController.text.isNotEmpty){

                                                        var data = {
                                                          'commentId': value.commentsListModel!.data![index].commentID.toString(),
                                                          'reply': replyController.text.toString(),
                                                        };

                                                        String data2 = json.encode(data);

                                                        value.postCommentReply(data, headers).then((value2){

                                                          value.getCommentsListData(null, headers, postId);
                                                          replyController.clear();
                                                          replyFocus.unfocus();
                                                        });

                                                      }

                                                    },
                                                    child: const Icon(Icons.send,
                                                      size: 20,
                                                    )
                                                );
                                              }
                                          ),

                                        ],
                                      ),
                                    ):SizedBox():
                                    SizedBox(),



                                  ],
                                ),
                              ),
                            ],
                          ),
                        );

                      },
                    );

                }
                return Container();

              }
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: (showReplyField == false)?Container(
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
                  child: (profilePic == null)?
                  Image.asset(blankProfilePicture, height: 35,width: 35,):
                  CachedNetworkImage(
                    height: 35,
                    width: 35,
                    imageUrl: "${AppUrl.profileImagebaseUrl}$profilePic",
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(blankProfilePicture, height: 35,width: 35,),
                  )
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
                    focusNode: commentFocus,
                    controller: commentController,
                    autofocus: false,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).textTheme.titleSmall!.color,
                    ),
                    decoration: InputDecoration(
                      hintText: "Write something...",
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

                Consumer<CommentsViewModel>(
                    builder: (context,value,child){
                      return InkWell(
                          onTap: (){

                            if(commentController.text.isNotEmpty){

                              var data = {
                                'postId': postId,
                                'comments': commentController.text.toString()
                              };

                              String data2 = json.encode(data);

                              value.postComment(data, headers).then((value2){

                                value.getCommentsListData(null, headers, postId);
                                commentController.clear();
                                commentFocus.unfocus();
                              });

                            }

                          },
                          child: Icon(Icons.send)
                      );
                    }
                ),

              ],
            ),
          ):SizedBox(),
        ),
      ),
    );
  }

  _showCommentEdit(BuildContext context, index) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text('Edit Comment',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: SizedBox(
              width: context.deviceWidth - 195,
              child: TextFormField(
                focusNode: editCommentFocus,
                controller: editCommentController,
                autofocus: true,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).textTheme.titleSmall!.color,
                ),
                decoration: InputDecoration(
                  hintText: "Write something...",
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
            actions: <Widget>[
              Consumer<CommentsViewModel>(
                  builder: (context,value,child){

                    if(value.editCommentLoading == true){
                      return Center(child: CircularProgressIndicator(color: primaryColor));
                    }else{
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("CANCEL",
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: primaryColor
                              ),
                            ),
                          ),
                          SizedBox(width: 40),
                          GestureDetector(
                            onTap: (){

                              if(editCommentController.text.isNotEmpty){

                                var data = {
                                  'commentID': value.commentsListModel!.data![index].commentID.toString(),
                                  'comments': editCommentController.text.toString(),
                                };

                                String data2 = json.encode(data);

                                value.editComment(data, headers).then((value2){
                                  value.getCommentsListData(null, headers, postId);
                                  editCommentController.clear();
                                  editCommentFocus.unfocus();

                                });

                              }
                              //copyrightId = value.copyrightId;
                              Navigator.pop(context);
                            },
                            child: Text("OK",
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: primaryColor
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                  }
              ),
            ],
          );
        });
  }

  _showReplyEdit(BuildContext context, index, index2) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text('Edit Reply',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: SizedBox(
              width: context.deviceWidth - 195,
              child: TextFormField(
                focusNode: editReplyFocus,
                controller: editReplyController,
                autofocus: true,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).textTheme.titleSmall!.color,
                ),
                decoration: InputDecoration(
                  hintText: "Write something...",
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
            actions: <Widget>[
              Consumer<CommentsViewModel>(
                  builder: (context,value,child){

                    if(value.editReplyLoading == true){
                      return Center(child: CircularProgressIndicator(color: primaryColor));
                    }else{
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("CANCEL",
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: primaryColor
                              ),
                            ),
                          ),
                          SizedBox(width: 40),
                          GestureDetector(
                            onTap: (){

                              if(editReplyController.text.isNotEmpty){

                                var data = {
                                  'replyID': value.commentsListModel!.data![index].commentReply![index2].replyID.toString(),
                                  'reply': editReplyController.text.toString(),
                                };

                                String data2 = json.encode(data);

                                value.editReply(data, headers).then((value2){
                                  value.getCommentsListData(null, headers, postId);
                                  editReplyController.clear();
                                  editReplyFocus.unfocus();

                                });

                              }
                              //copyrightId = value.copyrightId;
                              Navigator.pop(context);
                            },
                            child: Text("OK",
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: primaryColor
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                  }
              ),
            ],
          );
        });
  }

  Future<void> deleteCommentDialog (BuildContext context, index){
    return  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusValue))),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Delete Comment",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Text("Are you sure ?",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: <Widget>[



          Consumer<CommentsViewModel>(
              builder: (context,value,child){

                if(value.deleteCommentLoading == true){
                  return Center(child: CircularProgressIndicator(color: primaryColor));
                }else{
                  return  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          var data = {
                            'commentID': value.commentsListModel!.data![index].commentID.toString()
                          };

                          value.deleteComment(data, headers, index, context);
                        },
                        child: Text("YES",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: primaryColor
                          ),
                        ),
                      ),
                      SizedBox(width: 40),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);

                        },
                        child: Text("NO",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: primaryColor
                          ),
                        ),
                      ),
                    ],
                  );
                }

              }
          ),

        ],
      ),
    );
  }

  Future<void> deleteReplyDialog (BuildContext context, index, index2){
    return  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusValue))),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Delete Reply",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Text("Are you sure ?",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: <Widget>[



          Consumer<CommentsViewModel>(
              builder: (context,value,child){

                if(value.deleteCommentLoading == true){
                  return Center(child: CircularProgressIndicator(color: primaryColor));
                }else{
                  return  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          var data = {
                            'replyID': value.commentsListModel!.data![index].commentReply![index2].replyID.toString(),
                          };

                          value.deleteReply(data, headers, index,index2, context);
                        },
                        child: Text("YES",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: primaryColor
                          ),
                        ),
                      ),
                      SizedBox(width: 40),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);

                        },
                        child: Text("NO",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: primaryColor
                          ),
                        ),
                      ),
                    ],
                  );
                }

              }
          ),

        ],
      ),
    );
  }

}
