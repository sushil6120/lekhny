import 'package:flutter/material.dart';

class WritersInfoTextWidget extends StatelessWidget {
  //const WritersInfoTextWidget({Key? key}) : super(key: key);

  final String? boldText;
  final String? lightText;

  const WritersInfoTextWidget({
    required this.boldText,
    required this.lightText
});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(boldText!,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: 2),
        Text(lightText!,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
