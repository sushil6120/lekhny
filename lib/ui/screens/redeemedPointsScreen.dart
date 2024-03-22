import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/viewModel/allPointsDetailsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class RedeemedPointsScreen extends StatefulWidget {
  @override
  State<RedeemedPointsScreen> createState() => _RedeemedPointsScreenState();
}

class _RedeemedPointsScreenState extends State<RedeemedPointsScreen> {
  //const RedeemedPointsScreen({Key? key}) : super(key: key);

  int page = 1;

  final ScrollController scrollController = ScrollController();
  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  String? appLanguage;
  String? imageBaseUrl;
  var headers;

  @override
  void initState() {

    final allPointsDetailsViewModel = Provider.of<AllPointsDetailsViewModel>(context, listen: false);

    allPointsDetailsViewModel.redeemedPointsData = [];

    (()async{
      appLanguage = await sharedPreferencesViewModel.getLanguage();
    })().then((value){
      print('this is appLanguage ${appLanguage}');
      sharedPreferencesViewModel.getToken().then((value){
        headers = {
          'lekhnyToken': value.toString(),
          'AppLanguage': appLanguage??"3",
          'Authorization': 'Bearer ${value.toString()}'
        };

        allPointsDetailsViewModel.getRedeemedPointsData(headers, page, false);
        scrollController.addListener( _scroll);

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
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: true,
          elevation: 0.5,
          leading: AppBarBackButton(),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Redeemed Points',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: Consumer<AllPointsDetailsViewModel>(
            builder: (context,value,child){
              //print('satus ${value.homePageData.status}');
              //print('value ${value.homePageData.data![0]!.data!.length}');
              switch(value.allPointsDetailsData.status){
                case Status.LOADING :
                  return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      )
                  );

                case Status.ERROR :
                  return Text('${value.allPointsDetailsData.message.toString()} this is the error');

                case Status.COMPLETED :
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (value.load == true)? (value.redeemedPointsData.length + 1) : value.redeemedPointsData.length ,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 0.1,
                              color: Theme.of(context).disabledColor,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            if (index < value.redeemedPointsData.length){
                              return Container(
                                width: context.deviceWidth,
                                padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                                margin: EdgeInsets.only(bottom: 1),
                                decoration: BoxDecoration(

                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${index+1}",
                                          style: Theme.of(context).textTheme.bodyText2,
                                        ),
                                        SizedBox(width: 25),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Text("${value.redeemedPointsData[index].}",
                                            //   style: Theme.of(context).textTheme.caption,
                                            // ),
                                            // SizedBox(height: 4),
                                            SizedBox(
                                              width: context.deviceWidth- 150,
                                              child: Text("Account Details",
                                                style: Theme.of(context).textTheme.subtitle2,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text((value.redeemedPointsData[index].bankData == null ||
                                                value.redeemedPointsData[index].bankData == "null" ||
                                                value.redeemedPointsData[index].bankData == "")? "-" : value.redeemedPointsData[index].bankData!.replaceAll(" || ", "\n"),
                                              style: Theme.of(context).textTheme.caption,
                                            ),
                                            SizedBox(height: 8),

                                            SizedBox(
                                              width: context.deviceWidth- 150,
                                              child: Text("UPI ID",
                                                style: Theme.of(context).textTheme.subtitle2,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text((value.redeemedPointsData[index].uPIID == null ||
                                                value.redeemedPointsData[index].uPIID == "null" ||
                                                value.redeemedPointsData[index].uPIID == "")? "-" : value.redeemedPointsData[index].uPIID!,
                                              style: Theme.of(context).textTheme.caption,
                                            ),
                                            SizedBox(height: 8),
                                            Text("Approved",
                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                  color: primaryColor
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text("+ ₹ ${value.redeemedPointsData[index].redeemRequestPoints??"-"}",
                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                          color: primaryColor
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
                      ),
                      //SizedBox(height: verticalSpaceSmall),

                    ],
                  );

              }
              return Container();

            }
        ),
      ),
    );
  }

  Future <void> _scroll ()async{
    print("scroll working");
    final allPointsDetailsViewModel = Provider.of<AllPointsDetailsViewModel>(context, listen: false);
    if (allPointsDetailsViewModel.load == true){
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {

      page = page + 1;
      print(page);

      await allPointsDetailsViewModel.getRedeemedPointsData(headers, page, true);

      //paginationViewModel.setLoad(false);

    }
  }
}

//(index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
//(index==0)?EdgeInsets.only(left: 30, top:5,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:5,bottom: verticalSpaceSmall),
