import 'package:flutter/material.dart';
import 'package:herovickers_github_io/utils/app_functions.dart';
import 'package:herovickers_github_io/widgets/email_button.dart';
import 'package:herovickers_github_io/widgets/footer_message.dart';
import 'package:herovickers_github_io/widgets/socials.dart';

class Footer extends StatelessWidget {
  final bool isFooterCentered;

  Footer({Key key, this.isFooterCentered = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: isFooterCentered
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: <Widget>[
          FractionallySizedBox(
            widthFactor:
                AppFunctions.getScreenSize(context) == AppScreenSize.small
                    ? 1
                    : isFooterCentered ? 1 : 2 / 5,
            child: FooterMessage(isFooterCentered: isFooterCentered),
          ),
          SizedBox(
            height: 24.0,
          ),
          EmailButton(),
          SizedBox(
            height: 18.0,
          ),
          Socials(
            isFooterCentered: isFooterCentered,
          ),
        ],
      ),
    );
  }
}
