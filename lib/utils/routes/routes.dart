import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/ui/screens/SplashScreen.dart';
import 'package:lekhny/ui/screens/authorProfileScreen.dart';
import 'package:lekhny/ui/screens/bookDetailsScreen.dart';
import 'package:lekhny/ui/screens/bottomNavigationBarScreen.dart';
import 'package:lekhny/ui/screens/categoryBooks.dart';
import 'package:lekhny/ui/screens/changePasswordScreen.dart';
import 'package:lekhny/ui/screens/chooseLanguageScreen.dart';
import 'package:lekhny/ui/screens/commentsScreen.dart';
import 'package:lekhny/ui/screens/dailyCompetitionScreen.dart';
import 'package:lekhny/ui/screens/draftsScreen.dart';
import 'package:lekhny/ui/screens/enterBookDetailsScreen.dart';
import 'package:lekhny/ui/screens/forgetPasswordEnterOtpScreen.dart';
import 'package:lekhny/ui/screens/forgetPasswordNewPasswordScreen.dart';
import 'package:lekhny/ui/screens/forgetPasswordSendOtpScreen.dart';
import 'package:lekhny/ui/screens/loginScreen.dart';
import 'package:lekhny/ui/screens/commentReplyScreen.dart';
import 'package:lekhny/ui/screens/notificationScreen.dart';
import 'package:lekhny/ui/screens/onboardingScreen.dart';
import 'package:lekhny/ui/screens/pointsCreditedScreen.dart';
import 'package:lekhny/ui/screens/pointsDeductedScreen.dart';
import 'package:lekhny/ui/screens/pointsEarnedScreen.dart';
import 'package:lekhny/ui/screens/pointsRequestStatusScreen.dart';
import 'package:lekhny/ui/screens/pointsScreen.dart';
import 'package:lekhny/ui/screens/publishedPostScreen.dart';
import 'package:lekhny/ui/screens/publishedSeriesAllPartsScreen.dart';
import 'package:lekhny/ui/screens/publishedSeriesScreen.dart';
import 'package:lekhny/ui/screens/readingScreen.dart';
import 'package:lekhny/ui/screens/redeemPointsScreen.dart';
import 'package:lekhny/ui/screens/redeemedPointsScreen.dart';
import 'package:lekhny/ui/screens/requestPointsScreen.dart';
import 'package:lekhny/ui/screens/searchScreen.dart';
import 'package:lekhny/ui/screens/sellAllPosts.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/screens/signUpScreen.dart';
import 'package:lekhny/ui/screens/signupVerifyOTPScreen.dart';
import 'package:lekhny/ui/screens/textEditorScreen.dart';
import 'package:lekhny/ui/screens/upcomingBookScreen.dart';
import 'package:lekhny/ui/screens/verifyEmailOTP.dart';
import 'package:lekhny/ui/screens/verifyEmailScreen.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/slideTransition.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case  RoutesName.bottomNavigationBarScreen:
        return SlideRoute(page: BottomNavigationBarScreen(),x: 1, y: 0);
      case  RoutesName.login:
        return SlideRoute(page: LoginScreen(),x: 1, y: 0);
      case  RoutesName.signUpScreen:
        return SlideRoute(page: SignUpScreen(),x: 0, y: 1);
      case  RoutesName.splashScreen:
        return MaterialPageRoute(builder: (BuildContext context) => SplashScreen());
      case  RoutesName.onboardingScreen:
        return MaterialPageRoute(builder: (BuildContext context) => OnboardingScreen());
      case  RoutesName.bookDetailsScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (BuildContext context) => BookDetailsScreen(arguments));
      case  RoutesName.readingScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: ReadingScreen(arguments),x: 1, y: 0);
      case  RoutesName.textEditorScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: TextEditorScreen(arguments),x: 1, y: 0);
      case  RoutesName.enterBookDetailsScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: EnterBookDetailsScreen(arguments),x: 1, y: 0);
      case  RoutesName.draftScreen:
        return SlideRoute(page: DraftScreen(),x: 1, y: 0);
      case  RoutesName.publishedPostsScreen:
        return SlideRoute(page: PublishedPostScreen(),x: 1, y: 0);
      case  RoutesName.publishedSeriesScreen:
        return SlideRoute(page: PublishedSeriesScreen(),x: 1, y: 0);
      case  RoutesName.categoryBookScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: CategoryBooksScreen(arguments),x: 0, y: 1);
      case  RoutesName.pointsScreen:
        return SlideRoute(page: PointsScreen(),x: 1, y: 0);
      case  RoutesName.redeemPointsScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: RedeemPointsScreen(arguments),x: 0, y: 1);
      case  RoutesName.requestPointsScreen:
        return SlideRoute(page: RequestPointsScreen(),x: 0, y: 1);
      case  RoutesName.pointsEarnedScreen:
        return SlideRoute(page: PointsEarnedScreen(),x: 1, y: 0);
      case  RoutesName.pointsCreditedScreen:
        return SlideRoute(page: PointsCreditedScreen(),x: 1, y: 0);
      case  RoutesName.pointsDeductedScreen:
        return SlideRoute(page: PointsDeductedScreen(),x: 1, y: 0);
      case  RoutesName.redeemedPointsScreen:
        return SlideRoute(page: RedeemedPointsScreen(),x: 1, y: 0);
      case  RoutesName.pointsRequestStatusScreen:
        return SlideRoute(page: PointsRequestStatusScreen(),x: 1, y: 0);
      case  RoutesName.verifyEmailScreen:
        return SlideRoute(page: VerifyEmailScreen(),x: 0, y: 1);
      case  RoutesName.verifyEmailOTPScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: VerifyEmailOTPScreen(arguments),x: 1, y: 0);
      case  RoutesName.signupVerifyOTPScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: SignupVerifyEmailOTPScreen(arguments),x: 1, y: 0);
      case  RoutesName.publishedSeriesAllPartsScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: PublishedSeriesAllPartsScreen(arguments),x: 1, y: 0);
      case  RoutesName.dailyCompetitionScreen:
        return SlideRoute(page: DailyCompetitionScreen(),x: 1, y: 0);
      case  RoutesName.forgetPasswordSendOtpScreen:
        return SlideRoute(page: ForgetPasswordSendOtpScreen(),x: 0, y: 1);
      case  RoutesName.forgetPasswordEnterOtpScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: ForgetPasswordEnterOtpScreen(arguments),x: 1, y: 0);
      case  RoutesName.forgetPasswordNewPasswordScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: ForgetPasswordNewPasswordScreen(arguments),x: 1, y: 0);
      case  RoutesName.chooseLanguageScreen:
        return SlideRoute(page: ChooseLanguageScreen(),x: 1, y: 0);
      case  RoutesName.searchScreen:
        return SlideRoute(page: SearchScreen(),x: 0, y: 1);
      case  RoutesName.settingScreen:
        return SlideRoute(page: SettingsScreen(),x: 0, y: 1);
      case  RoutesName.authorProfileScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: AuthorProfileScreen(arguments),x: 0, y: 1);
      case  RoutesName.seeAllPostsScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: SeeAllPostsScreen(arguments),x: 1, y: 0);
      case  RoutesName.upcomingBookScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: UpcomingBookScreen(arguments),x: 1, y: 0);
      case  RoutesName.changePasswordScreen:
        return SlideRoute(page: ChangePasswordScreen(),x: 1, y: 0);
      case  RoutesName.commentScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: CommentsScreen(arguments),x: 1, y: 0);
      case  RoutesName.commentReplyScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return SlideRoute(page: CommentReplyScreen(arguments),x: 1, y: 0);
      case  RoutesName.notificationScreen:
        return SlideRoute(page: NotificationScreen(),x: 1, y: 0);
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('NO route defined'),
            ),
          );
        }
        );
    }
  }
}