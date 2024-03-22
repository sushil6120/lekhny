import 'dart:convert';

import 'package:delta_markdown/delta_markdown.dart';
import 'package:delta_to_html/delta_to_html.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/buttonBigWithIcon.dart';
import 'package:lekhny/ui/global%20widgets/circularProgressWidget.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/screens/stickydemopage.dart';
import 'package:lekhny/ui/widget/write%20page%20widget/writePageOptionWidget.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:lekhny/viewModel/enterBookDetailsScreenViewModel.dart';
import 'package:lekhny/viewModel/readingScreenViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:lekhny/viewModel/textEditorScreenViewModel.dart';
import 'package:markdown/markdown.dart' hide Text;
import 'package:provider/provider.dart';
import 'package:html2md/html2md.dart' as html2md;

class TextEditorScreen extends StatefulWidget {
  Map<String,dynamic>? args;
  TextEditorScreen(this.args);

  @override
  State<TextEditorScreen> createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  //const TextEditorScreen({Key? key}) : super(key: key);

  QuillController _controller = QuillController.basic();
  ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  String? html;
  String? appLanguage;
  String? text;
  dynamic headers;
  bool? run;
  String? dataPassed;
  String? mainPostId;

  @override
  void initState() {
    mainPostId = widget.args!["mainPostId"];

    print("this is mainPostId ${mainPostId}");

    //final st = jsonEncode(widget.args!["data"]);
    final st = widget.args!["data"];
    dataPassed = markdownToHtml(st!);
    _controller.document.insert(0, st);

    (()async{
      appLanguage = await sharedPreferencesViewModel.getLanguage();
    })().then((value){
      sharedPreferencesViewModel.getToken().then((value){

        headers = {
          'lekhnyToken': value.toString(),
          'AppLanguage': appLanguage??"3",
          'Authorization': 'Bearer ${value.toString()}'
        };
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override

  Widget build(BuildContext context) {

    final convertedValue = jsonEncode(_controller.document.toDelta().toJson());
    final markdown = deltaToMarkdown(convertedValue);
    html = markdownToHtml(markdown);

    final textEditorScreenViewModel = Provider.of<TextEditorScreenViewModel>(context);
    final enterBookDetailsScreenViewModel = Provider.of<EnterBookDetailsScreenViewModel>(context, listen: false);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: Theme.of(context).brightness,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Theme.of(context).brightness
      ),
      child: WillPopScope(

        onWillPop: ()async{

          focusNode.unfocus();
          dynamic shouldPop;

          if( _controller.document.isEmpty() || html == dataPassed){
           return true;

          }else{
            shouldPop = await showDialog(
              barrierDismissible: true,
              barrierColor: Colors.black26,
              context: context,
              builder: (ctx) => _showWillPopScopeWidget(
                  textEditorScreenViewModel,
                  context,
                  headers,
                  widget.args!["postId"],
                  widget.args!["isContest"],
                  widget.args!["contestId"],
                  html,
                  focusNode,
                  dataPassed,
                  _controller
              ),
            );
            return shouldPop!;
          }

        },
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                titleSpacing: 0,
                centerTitle: false,
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: Consumer<TextEditorScreenViewModel>(builder: (BuildContext context, value, Widget? child){
                  return (value.loading == true)?appBarSavingWidget(context):Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            focusNode.unfocus();
                            final convertedValue = jsonEncode(_controller.document.toDelta().toJson());
                            final markdown = deltaToMarkdown(convertedValue);
                            html = markdownToHtml(markdown);

                            if( _controller.document.isEmpty() || html == dataPassed){
                              Navigator.pop(context);

                            }else{
                              showDialog(
                                barrierDismissible: true,
                                barrierColor: Colors.black26,
                                context: context,
                                builder: (ctx) => _showWillPopScopeWidget(
                                    textEditorScreenViewModel,
                                    context,
                                    headers,
                                    widget.args!["postId"],
                                    widget.args!["isContest"],
                                    widget.args!["contestId"],
                                    html,
                                    focusNode,
                                    dataPassed,
                                    _controller
                                ),
                              );
                            }
                          },
                          child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        GestureDetector(

                          onTap: (){

                            focusNode.unfocus();

                            final convertedValue = jsonEncode(_controller.document.toDelta().toJson());
                            final markdown = deltaToMarkdown(convertedValue);
                            html = markdownToHtml(markdown);

                            enterBookDetailsScreenViewModel.setBookTitle(null);
                            enterBookDetailsScreenViewModel.setDescription(null);
                            enterBookDetailsScreenViewModel.setCategory(null);
                            enterBookDetailsScreenViewModel.setCopyright(null);
                            enterBookDetailsScreenViewModel.setSubCategory(null);
                            enterBookDetailsScreenViewModel.setCopyrightId(null);
                            enterBookDetailsScreenViewModel.setSelectedCategory(null);
                            if(enterBookDetailsScreenViewModel.selectedFile != null){
                              enterBookDetailsScreenViewModel.selectedFile = null;
                            }
                            if(enterBookDetailsScreenViewModel.selectedSubCategoryList != null){
                              enterBookDetailsScreenViewModel.setSubCategoryList(null);
                            }

                            if( _controller.document.isEmpty()){
                              Utils.toastMessage("Content is empty");

                            }else{

                              var addNextPartData = {
                                'postID': "${mainPostId}"
                              };

                              var addNewPostdata = {
                                'IsContest': widget.args!["isContest"].toString(),
                                'contestId': widget.args!["contestId"].toString()
                              };

                              var writePostData = {
                                'postID': "${widget.args!["postId"]}",
                                'podatData': html
                              };

                              if(mainPostId != null){
                                print("first completed");
                                textEditorScreenViewModel.addNextPart(
                                    addNextPartData, context, headers, html, false, false,
                                    widget.args!["isContest"].toString(),widget.args!["contestId"].toString(), mainPostId);

                              } else if (widget.args!["postId"] == null && mainPostId == null){
                                print("second completed");

                                textEditorScreenViewModel.addNewPost(
                                    addNewPostdata, context, headers, html, false, false,
                                    widget.args!["isContest"].toString(),widget.args!["contestId"].toString());

                                //textEditorScreenViewModel.writePost(writePostData, context, headers, html, false, false,
                                //widget.args!["isContest"].toString(),widget.args!["contestId"].toString(),  widget.args!["postId"].toString());

                              }else{
                                print("third completed");
                                if(html == dataPassed){

                                  Navigator.pushNamed(context, RoutesName.enterBookDetailsScreen,
                                      arguments: {
                                        "postId" : widget.args!["postId"].toString(),
                                        "isContest" : widget.args!["isContest"].toString(),
                                        "contestId": widget.args!["contestId"].toString()
                                  }
                                  );

                                }else{
                                  textEditorScreenViewModel.writePost(writePostData, context, headers, html, false, false,
                                      widget.args!["isContest"].toString(),widget.args!["contestId"].toString(),  widget.args!["postId"].toString(), mainPostId);
                                }

                                //print("this is postId ${postId}");
                              }
                            }

                          },
                          child: Text('Next',
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                color: primaryColor
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              body: Column(
                children: [
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                        border: Border.all(width: 0.5, color: Theme.of(context).textTheme!.bodyText1!.color!)
                    ),
                    child: QuillToolbar.basic(
                      controller: _controller,
                      showStrikeThrough: false,
                      showAlignmentButtons: true,
                      showFontFamily: false,
                      showFontSize: false,
                      showBackgroundColorButton: false,
                      showColorButton: false,
                      showCodeBlock: false,
                      showHeaderStyle: false,
                      showClearFormat: false,
                      showDividers: false,
                      showInlineCode: false,
                      showLink: false,
                      showListCheck: false,
                      showQuote: false,
                      showListNumbers: false,
                      showListBullets: false,
                      showSearchButton: false,
                      showSmallButton: false,
                      showIndent: false,
                      multiRowsDisplay: false,
                      toolbarIconSize: context.deviceWidth*0.055,
                      toolbarSectionSpacing: 2,
                      iconTheme: QuillIconTheme(
                          iconSelectedColor: colorLight1,
                          iconSelectedFillColor: primaryColor
                      ),
                    ),
                  ),
                  Expanded(
                    child: QuillEditor(
                      controller: _controller,
                      readOnly: false,
                      focusNode: focusNode,
                      scrollController: scrollController,
                      scrollable: true,
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                      autoFocus: false,
                      expands: false,
                      placeholder: "Write here...",
                      // true for view only mode
                    ),
                  )
                ],
              )
          ),
        ),
      )
    );
  }

  Widget _showWillPopScopeWidget(TextEditorScreenViewModel textEditorScreenViewModel, context, headers, postId, isContest, contestId, html, FocusNode focusNode, dataPassed, controller) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(radiusValue))
        ),
        height: 180,
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: verticalSpaceSmall),
                Text("Save Changes",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: verticalSpaceSmall),
                Text("Do you want save the changes ?",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).disabledColor
                  ),
                ),

              ],
            ),
            Consumer<TextEditorScreenViewModel>(builder: (BuildContext context, value, Widget? child){
              return Container(
                height: 48,
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                ),
                child: (value!.loading == true )?
                Center(
                    child: CircularProgressWidget(color: primaryColor, strokeWidth: 1.5)):
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
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

                        final convertedValue = jsonEncode(controller.document.toDelta().toJson());
                        final markdown = deltaToMarkdown(convertedValue);
                        html = markdownToHtml(markdown);

                        var addNextPartData = {
                          'postID': "${mainPostId}"
                        };

                        var addNewPostdata = {
                          'IsContest': isContest.toString(),
                          'contestId': contestId.toString()
                        };

                        var writePostData = {
                          'postID': "${postId}",
                          'podatData': "${html}"
                        };

                        print("this is addNextPartData ${writePostData}");

                        if(mainPostId != null){
                          print("first completed");
                          textEditorScreenViewModel.addNextPart( addNextPartData, context, headers, html, true, true,
                              isContest.toString(), contestId.toString(), mainPostId
                          );

                        } else if (postId == null && mainPostId == null){

                          print("second completed");
                          textEditorScreenViewModel.addNewPost(addNewPostdata, context, headers, html, true, true,
                              isContest.toString(), contestId.toString()
                          );
                        }else{
                          print("third completed");

                          textEditorScreenViewModel.writePost(writePostData, context, headers, html, true, true,
                              isContest.toString(), contestId.toString(), postId, null);

                          //print("this is postId ${postId}");
                        }
                      },
                      child: Text("SAVE",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: primaryColor
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),


          ],
        ),
      ),
    );
  }

  Widget appBarSavingWidget(context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Saving",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: primaryColor
              )
          ),
          SizedBox(width: 25),
          SizedBox(
              height: 20,
              width: 20,
              child: Center(child: CircularProgressWidget(color: primaryColor, strokeWidth: 1.5))
          )

        ],
      ),
    );
  }
}

