
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:herovickers_github_io/data/app_colors.dart';
import 'package:herovickers_github_io/utils/app_functions.dart';
import 'package:herovickers_github_io/widgets/social_icon_button.dart';

class WorkItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String playStoreLink;
  final String appStoreLink;
  final String githubLink;
  final int index;

  const WorkItem(
      {Key key,
      @required this.imagePath,
      @required this.title,
      @required this.description,
      @required this.index,
      this.appStoreLink = '',
      this.playStoreLink = '',
      this.githubLink = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppScreenSize appScreenSize = AppFunctions.getScreenSize(context);

    return Flex(
      direction: appScreenSize == AppScreenSize.small
          ? Axis.vertical
          : Axis.horizontal,
      textDirection: index.isEven ? TextDirection.ltr : TextDirection.rtl,
      children: <Widget>[
        appScreenSize == AppScreenSize.small
            ? _buildAppImage()
            : Expanded(
                child: _buildAppImage(),
              ),
        SizedBox(
          width: 50.0,
          height: 30.0,
        ),
        appScreenSize == AppScreenSize.small
            ? _buildAppDetails()
            : Expanded(
                child: _buildAppDetails(),
              ),
      ],
    );
  }

  Widget _buildAppImage() => Image.network(imagePath);

  Widget _buildAppDetails() {
    return Column(
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.WHITE_DARK,
              fontSize: 36,
              fontFamily: 'PlayfairDisplay-Regular'),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          description,
          style: TextStyle(
              fontSize: 24.0,
              color: AppColors.WHITE_DARK,
              fontFamily: 'SourceSansPro-ExtraLight'),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            playStoreLink.isNotEmpty
                ? SocialIconButton(
                    icon: MaterialCommunityIcons.google_play,
                    url: playStoreLink,
                  )
                : Container(),
            githubLink.isNotEmpty
                ? SocialIconButton(
                    icon: MaterialCommunityIcons.github_circle,
                    url: githubLink,
                  )
                : Container(),
            appStoreLink.isNotEmpty
                ? SocialIconButton(
                    icon: Fontisto.app_store,
                    url: appStoreLink,
                  )
                : Container()
          ],
        )
      ],
    );
  }
}
