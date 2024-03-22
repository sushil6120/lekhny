import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/utils/valueConstants.dart';

class ContestsTab extends StatefulWidget {
  @override
  State<ContestsTab> createState() => _ContestsTabState();
}

class _ContestsTabState extends State<ContestsTab> {
  //const ContestsTab({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  final List<String> items = [
    'Daily',
    'Monthly',
    'Yearly',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            // SliverToBoxAdapter(
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 15),
            //     //margin: EdgeInsets.symmetric(horizontal: 15),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
            //       color: Theme.of(context).canvasColor,
            //     ),
            //     height: 50,
            //
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text('Competition',
            //           style: Theme.of(context).textTheme.bodyText1,
            //         ),
            //         DropdownButtonHideUnderline(
            //           child: DropdownButton2(
            //             isExpanded: true,
            //             //underline: Divider(height: 2, color: primaryColor,),
            //             selectedItemHighlightColor: Theme.of(context).canvasColor,
            //             selectedItemBuilder: (BuildContext conetxt){
            //               return <Widget>[
            //                 Center(
            //                   child: Text('Daily',
            //                     style: TextStyle(
            //                         color: primaryColor
            //                     ),
            //                   ),
            //                 ),
            //                 Center(
            //                   child: Text('Monthly',
            //                     style: TextStyle(
            //                         color: primaryColor
            //                     ),
            //                   ),
            //                 ),
            //                 Center(
            //                   child: Text('Yearly',
            //                     style: TextStyle(
            //                         color: primaryColor
            //                     ),
            //                   ),
            //                 ),
            //
            //               ];
            //             },
            //             icon: Icon(Icons.arrow_drop_down_rounded,
            //             ),
            //             style: Theme.of(context).textTheme.bodyText2,
            //             hint: Text(selectedValue.toString()),
            //             items: items
            //                 .map((item) => DropdownMenuItem<String>(
            //               value: item,
            //               child: Text(
            //                 item,
            //                 style: Theme.of(context).textTheme.bodyText2,
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //             ))
            //                 .toList(),
            //             value: selectedValue,
            //             onChanged: (value) {
            //               setState(() {
            //                 selectedValue = value as String;
            //                 if(selectedValue == 'Daily'){
            //                   //context.locale = Locale('en');
            //
            //                 }else if(selectedValue == 'Monthly'){
            //                   //context.locale = Locale('hi');
            //
            //                 }else if(selectedValue == 'Yearly'){
            //                   //context.locale = Locale('ur');
            //
            //                 }
            //               });
            //             },
            //             buttonSplashColor: Colors.transparent,
            //             buttonHighlightColor: Colors.transparent,
            //             //buttonOverlayColor: MaterialStateProperty.all(Colors.transparent),
            //             iconSize: 24,
            //             iconEnabledColor: Theme.of(context).textTheme.headline4!.color!,
            //             // iconDisabledColor: Colors.grey,
            //             buttonHeight: 25,
            //             buttonWidth: 90,
            //             buttonPadding: EdgeInsets.only(left: 0, right: 0),
            //             // buttonDecoration: BoxDecoration(
            //             //   borderRadius: BorderRadius.circular(radiusValue),
            //             //   border: Border.all(
            //             //     color: Theme.of(context).textTheme.bodyText1!.color!,
            //             //   ),
            //             //   color: Colors.transparent,
            //             // ),
            //             //buttonElevation: 2,
            //             itemHeight: 40,
            //             //itemPadding: const EdgeInsets.only(left: 15, right: 15),
            //             dropdownMaxHeight: 150,
            //             dropdownWidth: 120,
            //             dropdownPadding: null,
            //             dropdownDecoration: BoxDecoration(
            //               // border: Border(
            //               //   bottom: BorderSide(width: 1, color: Theme.of(context).primaryIconTheme.color! ),
            //               // ),
            //               borderRadius: BorderRadius.circular(radiusValue),
            //               color: Theme.of(context).scaffoldBackgroundColor,
            //             ),
            //             dropdownElevation: 1,
            //             //scrollbarRadius: const Radius.circular(40),
            //             //scrollbarThickness: 6,
            //             //scrollbarAlwaysShow: true,
            //             offset: (context.locale == Locale('ur'))?Offset(0, -10):Offset(0, -10),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: verticalSpaceSmall),
                  Container(
                    width: context.deviceWidth,
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadingRowWidget(
                            headingText: 'Competition Particulars',
                            textButton: 'SEE ALL',
                            showTextButton: false,
                            onTap: (){}
                        ),
                        SizedBox(height: verticalSpaceExtraSmall),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text('- Registrations Strats on 1st Jan, 2022\n- Submission ends on 10th Jan, 2022\n- Results announced on 15th Jan, 2022',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              height: 1.6
                            ),
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
                      color: Theme.of(context).canvasColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadingRowWidget(
                            headingText: 'How To Enter',
                            textButton: 'SEE ALL',
                            showTextButton: false,
                            onTap: (){}
                        ),
                        SizedBox(height: verticalSpaceExtraSmall),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text('1. Subscribe us on our email.\n2. Process - Subscribe - Registered - Write option from menu bar - Choose language - Choose competition category - Upload your content - Wait for result.',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                height: 1.6
                            ),
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
                      color: Theme.of(context).canvasColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadingRowWidget(
                            headingText: 'Contest Rules',
                            textButton: 'SEE ALL',
                            showTextButton: false,
                            onTap: (){}
                        ),
                        SizedBox(height: verticalSpaceExtraSmall),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text('1. Participants should submit their work before 8pm on 18th Feb, 2021.\n'
                              '2. Paticipants must submit their original work.\n'
                              '3. Any entry containing cliche will not be accepted.\n'
                              '4. Mention the name or relationship for you are writing (Preferred using images)',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                height: 1.6
                            ),
                          ),
                        ),
                        SizedBox(height: verticalSpaceSmall),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormFieldBig(
                            obscureText: false,
                            controller: _nameController,
                            focusNode: nameFocusNode,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'This field is required';
                              }else if(!RegExp(r'^[a-zA-Z ]*$').hasMatch(value)){
                                return "Please enter a valid name";
                              }else{
                                return null;
                              }
                            },
                            onFieldSubmitted: (value){
                              Utils.fieldFocusChange(context, nameFocusNode, emailFocusNode);
                            },
                            keyboard: TextInputType.name,

                            hintText: 'Full Name',
                            height: bigButtonHeight,
                            prefixIcon: Icon(Icons.person_outline_outlined,
                              color: secondaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: verticalSpaceExtraSmall),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormFieldBig(
                            controller: _emailController,
                            focusNode: emailFocusNode,
                            obscureText: false,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'This field is required';
                              }else if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$").hasMatch(value)){
                                return "Please enter a valid email";
                              }else{
                                return null;
                              }
                            },
                            onFieldSubmitted: (value){

                            },
                            keyboard: TextInputType.emailAddress,
                            hintText: 'Email',
                            height: bigButtonHeight,
                            prefixIcon: Icon(Icons.email_outlined,
                              color: secondaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: verticalSpaceSmall),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: ButtonBig(
                              onTap: (){
                                Utils.toastMessage("This feature will be added soon.");

                              },
                              height: bigButtonHeight,
                              width: double.infinity,
                              backgroundColor: primaryColor,
                              text: 'SUBSCRIBE',
                              showProgress: false,
                              radius: radiusValue,
                              textPadding: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}
