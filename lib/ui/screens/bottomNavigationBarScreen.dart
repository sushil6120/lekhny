import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/screens/contestScreen.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/demoProfileScreen.dart';
import 'package:lekhny/ui/screens/homeScreen.dart';
import 'package:lekhny/ui/screens/libraryScreen.dart';
import 'package:lekhny/ui/screens/profileScreen.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/screens/writeScreen.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  //const BottomNavigationBarScreen({Key? key}) : super(key: key);
  int selectedIndex = 0;
  StreamSubscription? _streamSubscription;
  bool _initialURILinkHandled = false;

  final Screens = [
    HomeScreen(),
    LibraryScreen(),
    WriteScreen(),
    ContestScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    final sharedPreferencesViewModel = Provider.of<SharedPreferencesViewModel>(context, listen: false);
    sharedPreferencesViewModel.saveIsInstalled(true);
    _initURIHandler();
    _incomingLinkHandler();
    // TODO: implement initState
    super.initState();
  }
  Future<void> _initURIHandler() async {
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      Fluttertoast.showToast(
          msg: "Invoked _initURIHandler",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.transparent);
      try {
        final initialLink = await getInitialLink();
        // ignore: use_build_context_synchronously
        handleDeepLink(context, initialLink);
      } catch (err) {
        debugPrint("Failed to receive initial link: $err");
      }
    }
  }

  void _incomingLinkHandler() {
    if (!kIsWeb) {
      _streamSubscription = uriLinkStream.listen((Uri? link) {
        if (!mounted) {
          return;
        }
        handleDeepLink(context, link?.toString());
      }, onError: (Object err) {
        debugPrint('Error occurred: $err');
      });
    }
  }

  void handleDeepLink(BuildContext context, String? link) {
    if (link == null) return;

    Uri deepLink = Uri.parse(link);

    if (deepLink.pathSegments.contains("viewPost") &&
        deepLink.pathSegments.length == 2) {
      final postId = deepLink.pathSegments.last;

      // Navigator.of(context).pushNamed(RoutesName.singlePostScreen,
      //     arguments: {'postId': postId});

      Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
          arguments: {"postId" : postId.toString() }
      );
    } else {
      Navigator.of(context).pushNamed('/');
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Phoenix(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: IndexedStack(
            index: selectedIndex,
            children: Screens,
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashFactory: NoSplash.splashFactory,
            ),
            child: Container(
              //padding: EdgeInsets.only(top: 8),
              child: BottomNavigationBar(
                iconSize: 26,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Theme.of(context).textTheme.headline4!.color,
                unselectedItemColor: Theme.of(context).disabledColor,
                onTap: (index)=> setState(() {
                  selectedIndex = index;
                  print("this is index $index");
                  print("this is index $selectedIndex");
                }),
                currentIndex: selectedIndex,
                elevation: 10,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book_rounded,
                    ),
                    label: 'Library',

                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.call),
                  //   label: 'matc',
                  // ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.mode_edit_outline_outlined,
                    ),
                    label: 'Write',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.leaderboard_outlined,
                    ),
                    label: 'Contest',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.perm_identity_rounded,
                    ),
                    label: 'Profile',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.person),
                  //   label: 'Chat',
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusValue))),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Exit App",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text("Are you sure ?",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonBig(
                onTap: (){
                  //SystemNavigator.pop();
                  Navigator.of(context).pop(true);
                },
                width: 75,
                height: 40,
                backgroundColor: Theme.of(context).canvasColor,
                text: "Yes",
                showProgress: false,
                radius: radiusValue,
                textColor: Theme.of(context).textTheme.titleSmall!.color,
                textPadding: 0,
              ),
              const SizedBox(width: 40),
              ButtonBig(
                onTap: (){
                  Navigator.of(context).pop(false);
                },
                width: 75,
                height: 40,
                backgroundColor: primaryColor,
                text: "No",
                showProgress: false,
                radius: radiusValue,
                textColor: colorLightWhite,
                textPadding: 0,
              ),
            ],
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }
}
