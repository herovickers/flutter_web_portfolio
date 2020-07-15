

import 'package:flutter/material.dart';
import 'package:herovickers_github_io/data/app_colors.dart';
import 'package:herovickers_github_io/data/app_strings.dart';
import 'package:herovickers_github_io/widgets/work_item.dart';

class Work extends StatelessWidget {
  const Work({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 100.0, top: 50.0),
      child: Column(
        children: <Widget>[
          Text(
            AppStrings.WORK,
            style: TextStyle(
                color: AppColors.PRIMARY,
                fontSize: 48.0,
                fontFamily: 'PlayfairDisplaySC-Regular'),
          ),
          SizedBox(
            height: 100.0,
          ),
          WorkItem(
            imagePath: 'assets/assets/images/network_in_action.png',
            title: 'Network In Action Franchise',
            description:
                'Network In Action Franchise is a mobile app that helps manage communities and promote user engagement.',
            playStoreLink:
                'https://play.google.com/store/apps/details?id=com.networkinaction.networkinactionfranchise',
            appStoreLink:
                'https://apps.apple.com/us/app/network-in-action-franchise/id1504174781',
            index: 0, //TODO Reorganize code and remove this... index
          ),
          SizedBox(
            height: 75.0,
          ),
          FractionallySizedBox(
            widthFactor: 1.0,
            child: Container(
              height: 0.5,
              color: AppColors.WHITE_DARK,
              width: 500.0,
            ),
          ),
          SizedBox(
            height: 75.0,
          ),
          WorkItem(
            imagePath: 'assets/assets/images/world_holidays.png',
            title: 'World Holidays',
            description:
                'World Holidays is a mobile app that displays the various holidays in a year across the countries of the world and reminds you of your favourite holidays.',
            githubLink: 'https://github.com/herovickers/world_holidays',
            index: 1, //TODO Reorganize code and remove this... index
          ),
          SizedBox(
            height: 75.0,
          ),
          FractionallySizedBox(
            widthFactor: 1.0,
            child: Container(
              height: 0.5,
              color: AppColors.WHITE_DARK,
              width: 500.0,
            ),
          ),
          SizedBox(
            height: 75.0,
          ),
          WorkItem(
            imagePath: 'assets/assets/images/tag_battle.png',
            title: 'Tag Battle',
            description:
                'Tag battle is an app that combines social media and gaming taking competition to a new level. It makes use of hashtags to organize for battles for users to vote and earn rewards!',
            playStoreLink:
                'https://play.google.com/store/apps/details?id=app.outfitbattle',
            index: 2, //TODO Reorganize code and remove this... index
          ),
        ],
      ),
    );
  }
}
