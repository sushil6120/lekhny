import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/model/userProfileModelClass.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:provider/provider.dart';

class ProfileDashboard extends StatefulWidget {
  UserProfileModelClass? userProfileModel;

  ProfileDashboard({this.userProfileModel});


  @override
  State<ProfileDashboard> createState() => _ProfileDashboardState();
}

class _ProfileDashboardState extends State<ProfileDashboard> {
  //const ProfileDashboard({Key? key}) : super(key: key);
  final List<String> items = [
    'Reads',
    'Saved',
    'Series',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dashboardData = [
      {
        'info' : 'Total Points',
        'numbers' : "${widget.userProfileModel!.data![0].lekhnyCoins}",
        'icons' : Icons.currency_exchange
      },
      {
        'info' : 'Posts',
        'numbers' : "${widget.userProfileModel!.data![0].totalPost}",
        'icons' : Icons.my_library_books_outlined
      },
      {
        'info' : 'Following',
        'numbers' : "${widget.userProfileModel!.data![0].totalFollowing}",
        'icons' : Icons.person_add_alt_1_outlined
      },
      {
        'info' : 'Followers',
        'numbers' : "${widget.userProfileModel!.data![0].totalFollowers}",
        'icons' : Icons.people_alt_outlined
      },
      {
        'info' : 'Trophy',
        'numbers' : "${widget.userProfileModel!.data![0].totalTrophy}",
        'icons' : Icons.wine_bar_rounded
      },
      {
        'info' : 'Total Rank',
        'numbers' : "${widget.userProfileModel!.data![0].lekhnyRank}",
        'icons' : Icons.leaderboard_outlined
      },

    ];
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: SizedBox(height: verticalSpaceSmall)
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                ),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('All Time Statistics',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Icon(Icons.leaderboard_outlined,
                        size: 20,
                        color: primaryColor,
                    ),

                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: SizedBox(height: verticalSpaceSmall)
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: GridView.count(
                    physics: BouncingScrollPhysics(),
                    childAspectRatio: (context.deviceWidth>500)?1/1.7:1.25/1,
                    shrinkWrap: true,
                    crossAxisCount: (context.deviceWidth>500)?4:2,
                    crossAxisSpacing: 27,
                    mainAxisSpacing: 27,
                    children: List.generate(
                        dashboardData.length, (index) => GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
                        //     subCategoryList: categoryDemoData[index][List],
                        //     appBarTitle: categoryDemoData[index][String])));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                        decoration: BoxDecoration(

                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                         

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${dashboardData[index]['info']}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(height: verticalSpaceExtraSmall),
                                Icon(dashboardData[index]['icons'],
                                  size: 25,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text('${dashboardData[index]['numbers']}',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: SizedBox(height: verticalSpaceSmall)
            ),
          ]
      ),
    );
  }
}
