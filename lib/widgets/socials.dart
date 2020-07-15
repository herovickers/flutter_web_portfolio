
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:herovickers_github_io/data/app_strings.dart';
import 'package:herovickers_github_io/widgets/social_icon_button.dart';

class Socials extends StatelessWidget {
  final bool isFooterCentered;
  const Socials({Key key, @required this.isFooterCentered}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFooterCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: <Widget>[
        SocialIconButton(
            icon: MaterialCommunityIcons.github_circle,
            url: AppStrings.GITHUB_URL),
        SocialIconButton(
            icon: MaterialCommunityIcons.stack_overflow,
            url: AppStrings.STACKOVERFLOW_URL),
        SocialIconButton(
            icon: MaterialCommunityIcons.twitter, url: AppStrings.TWITTER_URL),
      ],
    );
  }
}