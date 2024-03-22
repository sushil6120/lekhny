import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/bookListContainer.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/searchTextFormFieldBig.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:sticky_headers/sticky_headers.dart';

class stickydemo extends StatelessWidget {
  const stickydemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SafeArea(
        child: CustomScrollView(
          primary: false,
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Text('Settings',
                      style: Theme.of(context).textTheme.headline4
                  ),
                  SizedBox(height: verticalSpaceLarge),
                ],
              ),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.red,
              expandedHeight: 200,
              title: Text('Settings',
                  style: Theme.of(context).textTheme.headline4
              ),
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                centerTitle: true,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SearchTextFormFieldBig(
                        hintText: 'Search Book',
                        height: 40,
                        suffixIcon: Icon(Icons.search,
                          color: Theme.of(context).disabledColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                )
              ),

            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical:25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 160,
                      width: context.deviceWidth*0.15,
                      child: SvgPicture.asset(pillar,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 200,
                      width: context.deviceWidth*0.15,
                      child: SvgPicture.asset(pillar,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 240,
                      width: context.deviceWidth*0.15,
                      child: SvgPicture.asset(pillar,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 280,
                      width: context.deviceWidth*0.15,
                      child: SvgPicture.asset(pillar,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 320,
                      width: context.deviceWidth*0.15,
                      child: SvgPicture.asset(pillar,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 360,
                      width: context.deviceWidth*0.15,
                      child: SvgPicture.asset(pillar,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: verticalSpaceSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      width: context.deviceWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('greetings'.tr().toString(),
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: Theme.of(context).textTheme.bodyText1!.color!
                              )
                          ),
                          SizedBox(height: 5),
                          Text('Rajan Gupta',
                              style: Theme.of(context).textTheme.subtitle1
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: verticalSpaceSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SearchTextFormFieldBig(
                      hintText: 'Search Book',
                      height: 40,
                      suffixIcon: Icon(Icons.search,
                        color: Theme.of(context).disabledColor,
                        size: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: verticalSpaceSmall),
                  BookListContainer(
                    listViewHeight: 213,
                    headingWidget: HeadingRowWidget(
                        headingText: 'Your Reads',
                        textButton: 'SEE ALL',
                        showTextButton: true,
                        onTap: (){}
                    ),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: demoData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: (context.locale == Locale('ur'))?
                          (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                          (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                          child: BookWidget(
                              onTap: (){},
                              crossAxisAlignment: CrossAxisAlignment.start,
                              showParts: false,
                              showViews: true,
                              showBookTitle: true,
                              showWriter: true,
                              partsValue: demoData[index]["parts"],
                              partsSpace: 0,
                              imgSpace: 10,
                              imageHeight: 100,
                              imageWidth: 150,
                              imgUrl: demoData[index]["bookCover"],
                              viewsValue: demoData[index]["views"],
                              bookTextWidth: 100,
                              bookName: demoData[index]["book"],
                              bookNameSpace: 4,
                              writerTextWidth: 100,
                              writerName: demoData[index]["author"]
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: verticalSpaceSmall),
                  Container(
                    width: context.deviceWidth,
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HeadingRowWidget(
                            headingText: 'Top Picks For You',
                            textButton: 'SEE ALL',
                            showTextButton: true,
                            onTap: (){}
                        ),
                        SizedBox(height: verticalSpaceSmall),
                        Container(
                          height: 180,
                          //color: Colors.red,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: demoData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      //margin: EdgeInsets.only(left: 30, top:5),
                                      margin: (context.locale == Locale('ur'))?
                                      (index==0)?EdgeInsets.only(right: 30, top:2,bottom: verticalSpaceSmall):EdgeInsets.only(right: 15, top:2,bottom: verticalSpaceSmall):
                                      (index==0)?EdgeInsets.only(left: 30, top:2,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:2,bottom: verticalSpaceSmall),
                                      width: 110,
                                      height: 160,
                                      alignment: Alignment.topCenter,
                                      decoration: BoxDecoration(
                                        //color: Colors.red,
                                          borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 0,
                                                blurRadius: 5,
                                                offset: Offset(0, 5)
                                            )
                                          ]
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 1 /1.5,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                          child: Image.network("https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg",
                                            fit: BoxFit.cover,
                                            alignment: Alignment.bottomCenter,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: verticalSpaceSmall),
                  BookListContainer(
                    listViewHeight: 231,
                    headingWidget: HeadingRowWidget(
                        headingText: 'Top Series',
                        textButton: 'SEE ALL',
                        showTextButton: true,
                        onTap: (){}
                    ),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: demoData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: (context.locale == Locale('ur'))?
                          (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                          (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                          child: BookWidget(
                              onTap: (){},
                              crossAxisAlignment: CrossAxisAlignment.start,
                              showParts: true,
                              showViews: true,
                              showBookTitle: true,
                              showWriter: true,
                              partsValue: demoData[index]["parts"],
                              partsSpace: 4,
                              imgSpace: 10,
                              imageHeight: 100,
                              imageWidth: 150,
                              imgUrl: demoData[index]["bookCover"],
                              viewsValue: demoData[index]["views"],
                              bookTextWidth: 100,
                              bookName: demoData[index]["book"],
                              bookNameSpace: 4,
                              writerTextWidth: 100,
                              writerName: demoData[index]["author"]
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: verticalSpaceSmall),
                  BookListContainer(
                    listViewHeight: 213,
                    headingWidget: HeadingRowWidget(
                        headingText: 'Top English Stories',
                        textButton: 'SEE ALL',
                        showTextButton: true,
                        onTap: (){}
                    ),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: demoData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: (context.locale == Locale('ur'))?
                          (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                          (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                          child: BookWidget(
                              onTap: (){},
                              crossAxisAlignment: CrossAxisAlignment.start,
                              showParts: false,
                              showViews: true,
                              showBookTitle: true,
                              showWriter: true,
                              partsValue: demoData[index]["parts"],
                              partsSpace: 0,
                              imgSpace: 10,
                              imageHeight: 100,
                              imageWidth: 150,
                              imgUrl: demoData[index]["bookCover"],
                              viewsValue: demoData[index]["views"],
                              bookTextWidth: 100,
                              bookName: demoData[index]["book"],
                              bookNameSpace: 4,
                              writerTextWidth: 100,
                              writerName: demoData[index]["author"]
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: verticalSpaceSmall),
                  Container(
                    width: context.deviceWidth,
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HeadingRowWidget(
                            headingText: 'Discover Writers',
                            textButton: 'SEE ALL',
                            showTextButton: true,
                            onTap: (){}
                        ),
                        SizedBox(height: verticalSpaceSmall),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: demoData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: (context.locale == Locale('ur'))?
                                (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                                (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            height: 100,
                                            width: 100,
                                            child: CircleAvatar(
                                              foregroundImage: NetworkImage('https://www.siliconindia.com/news/newsimages/special/xbq2g5fZ.jpeg',
                                              ) ,
                                            )
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          width: 125,
                                          child: Text('${demoData[index]['writer']}',
                                            style: Theme.of(context).textTheme.subtitle2,
                                            textAlign: TextAlign.center,
                                            softWrap: true,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        SizedBox(
                                          width: 125,
                                          child: Text('${demoData[index]["author"]}',
                                            style: Theme.of(context).textTheme.caption,
                                            textAlign: TextAlign.center,
                                            softWrap: false,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ButtonBig(
                                      height: 30,
                                      width: 100,
                                      backgroundColor: primaryColor,
                                      text: 'Follow',
                                      showProgress: false,
                                      radius: radiusValue,
                                      fontSize: 12,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: verticalSpaceSmall),
                  Container(
                    width: context.deviceWidth,
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadingRowWidget(
                            headingText: 'Upcoming Book',
                            textButton: 'SEE ALL',
                            showTextButton: false,
                            onTap: (){}
                        ),
                        SizedBox(height: verticalSpaceSmall),
                        SizedBox(
                          height: 180,
                          child: Row(
                            children: [
                              Container(
                                width: 112,
                                height: 168,
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                  //color: Colors.red,
                                  borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1 /1.5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                    child: Image.network("https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg",
                                      fit: BoxFit.cover,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  //SizedBox(height: verticalSpaceSmall),
                                  // Text('MYSTERY',
                                  //   style: Theme.of(context).textTheme.overline!.copyWith(
                                  //     color: primaryColor,
                                  //   ),
                                  // ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: context.deviceWidth-157,
                                        child: Text('The Power of positive thinking',
                                          style: Theme.of(context).textTheme.subtitle1,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      SizedBox(
                                        width: context.deviceWidth-157,
                                        child: Text('Mike Tyson Junior',
                                          style: Theme.of(context).textTheme.caption!.copyWith(
                                              color: Theme.of(context).disabledColor
                                          ),
                                          textAlign: TextAlign.start,
                                          softWrap: false,
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: context.deviceWidth-157,
                                        child: Text("It is a long established the fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now",
                                          style: Theme.of(context).textTheme.caption,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

                                    ],
                                  ),
                                  Text('Read More',
                                    style: Theme.of(context).textTheme.caption!.copyWith(
                                        color: primaryColor
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: verticalSpaceSmall),
                  BookListContainer(
                    listViewHeight: 213,
                    headingWidget: HeadingRowWidget(
                        headingText: 'More Upcoming Books',
                        textButton: 'SEE ALL',
                        showTextButton: false,
                        onTap: (){}
                    ),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: demoData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: (context.locale == Locale('ur'))?
                          (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                          (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                          child: BookWidget(
                              onTap: (){},
                              crossAxisAlignment: CrossAxisAlignment.start,
                              showParts: false,
                              showViews: false,
                              showBookTitle: true,
                              showWriter: true,
                              partsValue: demoData[index]["parts"],
                              partsSpace: 0,
                              imgSpace: 10,
                              imageHeight: 100,
                              imageWidth: 150,
                              imgUrl: demoData[index]["bookCover"],
                              viewsValue: demoData[index]["views"],
                              bookTextWidth: 100,
                              bookName: demoData[index]["book"],
                              bookNameSpace: 4,
                              writerTextWidth: 100,
                              writerName: demoData[index]["author"]
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}
