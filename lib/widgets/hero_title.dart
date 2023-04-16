import 'package:flutter/material.dart';

import '../utils/utils.dart';

class HeroTitle extends StatelessWidget {
  const HeroTitle({
    Key? key,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  final String? title, subtitle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //flex: 2,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title!,
              style: TextStyle(
                fontSize: 50,
                // fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: Utils.screenHeight! * 0.005),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: Utils.screenHeight! * 0.005),
          ],
        ),
      ),
    );
  }
}
