

import 'package:flutter/material.dart';
import 'package:herovickers_github_io/data/app_colors.dart';
import 'package:herovickers_github_io/data/app_strings.dart';

class AboutDetails extends StatelessWidget {
  const AboutDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          AppStrings.FULL_NAME,
          style: TextStyle(
              color: Colors.white,
              fontSize: 48.0,
              fontFamily: 'PlayfairDisplaySC-Regular'),
        ),
        SizedBox(
          height: 32.0,
        ),
        RichText(
          text: TextSpan(
              style: TextStyle(
                fontSize: 34.0,
              ),
              children: AppStrings.BODY_SUMMARY.split(' ').map(
                (string) {
                  return TextSpan(
                      text: string + ' ',
                      style: TextStyle(
                          color: AppStrings.BOLDED_STRINGS.contains(string)
                              ? AppColors.PRIMARY
                              : AppColors.WHITE_DARK,
                          fontSize: 36,
                          fontFamily: 'PlayfairDisplay-Regular'));
                },
              ).toList()),
        ),
        SizedBox(
          height: 32.0,
        ),
        Text(
          AppStrings.BODY_MESSAGE,
          style: TextStyle(
              fontSize: 24.0,
              color: AppColors.WHITE_DARK,
              fontFamily: 'SourceSansPro-ExtraLight'),
        ),
      ],
    );
  }
}
