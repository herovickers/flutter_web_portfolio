import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:herovickers_github_io/data/app_colors.dart';

class ScrollToTopChevron extends StatelessWidget {
  final void Function() onPressed;
  final double opacity;

  const ScrollToTopChevron(
      {Key key, @required this.onPressed, @required this.opacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      color: Colors.transparent,
      child: IconButton(
        onPressed: onPressed,
        iconSize: 96.0,
        icon: AnimatedOpacity(
          opacity: opacity,
          duration: Duration(seconds: 1),
          child: Icon(
            EvilIcons.chevron_up, //Icons.arrow_upward,
            color: AppColors.WHITE_DARK,
          ),
        ),
      ),
    );
  }
}
