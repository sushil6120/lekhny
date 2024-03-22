import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/bookStatsWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';

class ReadingScreenDrawer extends StatefulWidget {
  int? currentChapterIndex;
  SingleBookPartsModelClass? singleBookPartsModel;
  ReadingScreenDrawer({this.singleBookPartsModel, this.currentChapterIndex});


  @override
  State<ReadingScreenDrawer> createState() => _ReadingScreenDrawerState();
}

class _ReadingScreenDrawerState extends State<ReadingScreenDrawer> {


  //const ReadingScreenDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("this is signal book parts ${widget.singleBookPartsModel!.data![0].bookTitle}");
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: context.deviceWidth*0.75,
          height: context.deviceHeight- (context.safeAreaHeight*2),
          child: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: context.appBarHeight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppBarBackButton(),
                      SizedBox(width: 20),
                      Text("Chapters",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      //controller: scrollController,
                      itemCount: widget.singleBookPartsModel!.data!.length,
                      itemBuilder: (BuildContext context, int index ){
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, RoutesName.readingScreen,
                                arguments: {"postId" : widget.singleBookPartsModel!.data![index].id, "index" : index}
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: (widget.currentChapterIndex == index)?primaryColor:Theme.of(context).canvasColor,
                              border: Border(bottom: BorderSide(
                                  width: 0.2,
                                  color: Theme.of(context).textTheme.bodyText1!.color!
                              ))
                            ),

                            padding: EdgeInsets.only(bottom: 15, top: 15, left: 15, right: 15),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("CHAPTER - ${index+1}",
                                  style: Theme.of(context).textTheme.overline!.copyWith(
                                    color: (widget.currentChapterIndex == index)?colorLight2:primaryColor,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                SizedBox(
                                  width: context.deviceWidth*0.75 - 30,
                                  child: Text("${widget.singleBookPartsModel!.data![index].bookTitle}",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: (widget.currentChapterIndex == index)?colorLight2:Theme.of(context).textTheme.bodyText1!.color
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
