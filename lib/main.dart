import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/firebase_options.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/utils/routes/routes.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/scrollBehavior.dart';
import 'package:lekhny/viewModel/DailyCompetitionViewModel.dart';
import 'package:lekhny/viewModel/allPointsDetailsViewModel.dart';
import 'package:lekhny/viewModel/authViewModel.dart';
import 'package:lekhny/viewModel/categoryBookViewModel.dart';
import 'package:lekhny/viewModel/commentsViewModel.dart';
import 'package:lekhny/viewModel/emailVerificationViewModel.dart';
import 'package:lekhny/viewModel/enterBookDetailsScreenViewModel.dart';
import 'package:lekhny/viewModel/followUnfollowViewModel.dart';
import 'package:lekhny/viewModel/forgetPasswordViewModel.dart';
import 'package:lekhny/viewModel/leaderboardViewModel.dart';
import 'package:lekhny/viewModel/pofilePostsViewModel.dart';
import 'package:lekhny/viewModel/profileViewModel.dart';
import 'package:lekhny/viewModel/publishedSeriesAllPartsViewModel.dart';
import 'package:lekhny/viewModel/readingScreenViewModel.dart';
import 'package:lekhny/viewModel/redeemPointsViewModel.dart';
import 'package:lekhny/viewModel/searchScreenViewModel.dart';
import 'package:lekhny/viewModel/seeAllPostsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:lekhny/viewModel/textEditorScreenViewModel.dart';
import 'package:lekhny/viewModel/upcomingBookDetailsViewModel.dart';
import 'package:lekhny/viewModel/writerPostsViewModel.dart';
import 'package:lekhny/viewModel/writerProfileViewModel.dart';
import 'package:provider/provider.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      EasyLocalization(
          supportedLocales: const[
            Locale('en'),
            Locale('hi'),
            Locale('ur'),
          ],
          fallbackLocale: Locale('en'),
          path: 'assets/translations',
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthViewModel()),
        ChangeNotifierProvider(create: (_)=> SharedPreferencesViewModel()),
        ChangeNotifierProvider(create: (_)=> ThemeManager()),
        ChangeNotifierProvider(create: (_)=> TextEditorScreenViewModel()),
        ChangeNotifierProvider<EnterBookDetailsScreenViewModel>.value(value: EnterBookDetailsScreenViewModel() ),
        ChangeNotifierProvider(create: (_)=> CategoryBookViewModel()),
        ChangeNotifierProvider(create: (_)=> ProfileViewModel()),
        ChangeNotifierProvider(create: (_)=> ProfilePostsViewModel()),
        ChangeNotifierProvider(create: (_)=> EmailVerificationViewModel()),
        ChangeNotifierProvider(create: (_)=> RedeemPointsViewModel()),
        ChangeNotifierProvider(create: (_)=> AllPointsDetailsViewModel()),
        ChangeNotifierProvider(create: (_)=> ReadingScreenViewModel()),
        ChangeNotifierProvider(create: (_)=> PublishedSeriesAllPartsViewModel()),
        ChangeNotifierProvider(create: (_)=> DailyCompetitionViewModel()),
        ChangeNotifierProvider(create: (_)=> ForgetPasswordViewModel()),
        ChangeNotifierProvider(create: (_)=> SearchScreenViewModel()),
        ChangeNotifierProvider(create: (_)=> SeeAllPostsViewModel()),
        ChangeNotifierProvider(create: (_)=> FollowUnfollowViewModel()),
        ChangeNotifierProvider(create: (_)=> UpcomingBookDetailsViewModel()),
        ChangeNotifierProvider(create: (_)=> WriterProfileViewModel()),
        ChangeNotifierProvider(create: (_)=> WriterPostsViewModel()),
        ChangeNotifierProvider(create: (_)=> CommentsViewModel()),
        ChangeNotifierProvider(create: (_)=> LeaderboardViewModel()),
      ],
      child: Builder(builder: (BuildContext context){
        final themeManager = Provider.of<ThemeManager>(context);
        return MaterialApp(
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            themeMode: themeManager.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            title :'Lekhny',
            //home: SignUpWithGoogle().handleAuthState(),
            initialRoute: RoutesName.splashScreen,
            onGenerateRoute: Routes.generateRoute,
            scrollBehavior: MyBehavior(),
        );
      }),
    );
  }
}
