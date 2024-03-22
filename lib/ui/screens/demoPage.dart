import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/screens/bottomNavigationBarScreen.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/utils/valueConstants.dart';

class demoPage extends StatelessWidget {
  //const demoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Icon(Icons.person_outline_outlined,
                  color: Theme.of(context).textTheme.headline4!.color,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
                    },
                    child: Icon(
                      Icons.mail_outline_rounded,color: Theme.of(context).textTheme.headline4!.color,
                    ),
                  ),
                  SizedBox(width: 25),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
                    },
                    child: Icon(
                      Icons.settings_outlined,color: Theme.of(context).textTheme.headline4!.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
