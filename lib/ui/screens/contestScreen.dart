import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/screens/contestsTab.dart';
import 'package:lekhny/ui/screens/profileDashboard.dart';
import 'package:lekhny/ui/screens/profileLibrary.dart';
import 'package:lekhny/ui/screens/demoGalleryScreen.dart';
import 'package:lekhny/ui/screens/demoIgtvScreen.dart';
import 'package:lekhny/ui/screens/demoReelsScreen.dart';
import 'package:lekhny/ui/screens/profilePosts.dart';
import 'package:lekhny/ui/screens/resultsTab.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/widget/profile%20page%20widget/writersInfoTextWidget.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/contestsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class ContestScreen extends StatefulWidget {
  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  //const ContestScreen({Key? key}) : super(key: key);
  String? appLanguage;
  String? imageBaseUrl;

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();
  ContestsViewModel contestViewModel = ContestsViewModel();


  @override
  void initState() {
    (()async{
      appLanguage = await sharedPreferencesViewModel.getLanguage();

    })().then((value){

      print('this is appLanguage ${appLanguage}');

      sharedPreferencesViewModel.getToken().then((value){
        final headers = {
          'lekhnyToken': value.toString(),
          'AppLanguage': appLanguage??"3",
          'Authorization': 'Bearer ${value.toString()}'
        };
        print(" this is token ${value.toString()}");
        //bookDetailsScreenViewModel.getSingleBookDetailsData(widget.args!["postId"], null, headers);
        contestViewModel.getContestData(null, headers);
        print("init is working");
      });
    });

    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('contests'.tr().toString(),
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<ContestsViewModel>(
        create: (BuildContext context)=> contestViewModel,
        child: Consumer<ContestsViewModel>(
            builder: (context,value,child){
              //print('value ${value.singleBookDataModel!.data![0].postData}');
              switch(value.contestData.status){
                case Status.LOADING :
                  return Scaffold(
                    body: Stack(
                      children: [
                        Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            )
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: context.safeAreaHeight,
                              color: Colors.black
                          ),
                        )

                      ],
                    ),
                  );

                case Status.ERROR :
                  return Scaffold(
                      body: Text('${value.contestData.message.toString()} this is the error')
                  );

                case Status.COMPLETED :
                  return DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Material(
                            child: TabBar(
                              indicatorColor: primaryColor,
                              tabs: [
                                Tab(child: Text('Contests',
                                  style: Theme.of(context).textTheme.subtitle1,),
                                ),
                                Tab(child: Text('Results',
                                  style: Theme.of(context).textTheme.subtitle1,),
                                ),
                              ],
                            ),

                          ),
                          Expanded(
                              child: TabBarView(
                                children: [
                                  ContestsTab(),
                                  ResultsTab(value.monthlyCompetitionResultModel),
                                ],
                              )
                          )
                        ],
                      )
                  );

              }
              return Container();

            }
        ),

      ),

    );
  }
}
