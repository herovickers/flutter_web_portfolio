import 'package:flutter/material.dart';
import 'package:herovickers_github_io/data/app_strings.dart';

class FooterMessage extends StatelessWidget {
  final bool isFooterCentered;
  const FooterMessage({Key key, @required this.isFooterCentered})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.FOOTER_MESSAGE,
      textAlign: isFooterCentered ? TextAlign.center : null,
      style: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontFamily: 'PlayfairDisplay-Regular'),
    );
  }
}
