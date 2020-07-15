import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:herovickers_github_io/data/app_colors.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    Key key,
    @required this.icon,
    @required this.url,
  }) : super(key: key);

  final IconData icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    var buttonOpacity = 1.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return IconButton(
          iconSize: 36,
          icon: MouseRegion(
            onEnter: (pointerHoverEvent) {
              setState(() {
                buttonOpacity = 0.5;
              });
            },
            onExit: (pointerHoverEvent) {
              setState(() {
                buttonOpacity = 1.0;
              });
            },
            child: Container(
              color: Colors.black,
              child: Icon(
                icon,
                color: AppColors.PRIMARY.withOpacity(buttonOpacity),
              ),
            ),
          ),
          onPressed: () {
            html.window.open(url, '_blank');
          },
        );
      }),
    );
  }
}
