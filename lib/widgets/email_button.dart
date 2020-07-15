import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:herovickers_github_io/data/app_colors.dart';
import 'package:herovickers_github_io/data/app_strings.dart';

class EmailButton extends StatefulWidget {
  const EmailButton({
    Key key,
  }) : super(key: key);

  @override
  _EmailButtonState createState() => _EmailButtonState();
}

class _EmailButtonState extends State<EmailButton> {
  Color textColor = AppColors.BLACK;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (pointerHoverEvent) {
        setState(() {
          textColor = AppColors.WHITE;
        });
      },
      onExit: (pointerHoverEvent) {
        setState(() {
          textColor = AppColors.BLACK;
        });
      },
      child: FlatButton(
        color: AppColors.WHITE,
        hoverColor: AppColors.PRIMARY,
        onPressed: () {
          html.window.open(
              'mailto: victoreronmosele@gmail.com?subject=Hello!&body=Hi,%20Victor',
              '_top');
        },
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Text(
          AppStrings.EMAIL,
          style: TextStyle(
              fontSize: 20.0,
              color: textColor,
              fontFamily: 'SourceSansPro-ExtraLight'),
        ),
      ),
    );
  }
}
