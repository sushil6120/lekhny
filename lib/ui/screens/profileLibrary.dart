import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/model/libraryCollectionModelClass.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/valueConstants.dart';

class ProfileLibrary extends StatefulWidget {
  LibraryCollectionModelClass? libraryCollectionModelClass;

  ProfileLibrary({this.libraryCollectionModelClass});

  @override
  State<ProfileLibrary> createState() => _ProfileLibraryState();
}

class _ProfileLibraryState extends State<ProfileLibrary> {

  String? imageBaseUrl;

  @override
  Widget build(BuildContext context) {

    imageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;
    return Scaffold(
      body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.only(left: 15, right: 15, top: verticalSpaceSmall, bottom: verticalSpaceSmall),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                ),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Your Collection',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Icon(Icons.library_books_outlined,
                      size: 20,
                      color: primaryColor,
                    ),

                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5, bottom: verticalSpaceSmall),
                child: GridView.count(
                    physics: BouncingScrollPhysics(),
                    childAspectRatio: (context.deviceWidth>500)?1/1.7:1/1.85,
                    shrinkWrap: true,
                    crossAxisCount: (context.deviceWidth>500)?6:3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: List.generate(
                        widget.libraryCollectionModelClass!.data!.length, (index) => GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
                        //     subCategoryList: categoryDemoData[index][List],
                        //     appBarTitle: categoryDemoData[index][String])));
                      },
                      child: BookWidget(
                          onTap: (){},
                          crossAxisAlignment: CrossAxisAlignment.center,
                          showParts: false,
                          showViews: false,
                          showBookTitle: true,
                          showWriter: true,
                          partsValue: "",
                          partsSpace: 0,
                          imgSpace: (context.locale == Locale('ur'))?5:10,
                          imageHeight: 100,
                          imageWidth: 150,
                          imgUrl: "${imageBaseUrl}${widget.libraryCollectionModelClass!.data![index].postCover}",
                          viewsValue: "${widget.libraryCollectionModelClass!.data![index].totalviewes}",
                          bookTextWidth: 100,
                          bookName: "${widget.libraryCollectionModelClass!.data![index].postTitle}",
                          bookNameSpace: 0,
                          writerTextWidth: 100,
                          writerName: "${widget.libraryCollectionModelClass!.data![index].authName}"
                      ),
                    ))
                ),
              ),
            ),
          ]
      ),
    );
  }
}
