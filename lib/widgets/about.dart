
import 'package:flutter/material.dart';
import 'package:herovickers_github_io/utils/app_functions.dart';
import 'package:herovickers_github_io/widgets/about_details.dart';
import 'package:herovickers_github_io/widgets/user_picture.dart';

class About extends StatelessWidget {
  const About({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppScreenSize appScreenSize = AppFunctions.getScreenSize(context);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: AboutDetails(),
            ),
            SizedBox(
              width: appScreenSize == AppScreenSize.large
                  ? 20.0
                  : appScreenSize == AppScreenSize.medium ? 100.0 : 0.0,
            ),
            appScreenSize == AppScreenSize.large
                ? Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: UserPicture(),
                    ),
                  )
                : Container()
          ],
        ),
        appScreenSize == AppScreenSize.large
            ? Container()
            : Container(
                margin: appScreenSize == AppScreenSize.small
                    ? EdgeInsets.symmetric(vertical: 32.0)
                    : null,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor:
                        appScreenSize == AppScreenSize.small ? 1.0 : 2 / 5,
                    child: UserPicture(),
                  ),
                ))
      ],
    );
  }
}
