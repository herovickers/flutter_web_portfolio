import 'package:flutter/material.dart';
import 'package:herovickers_github_io/pages/home_page.dart';
import 'package:herovickers_github_io/widgets/about.dart';
import 'package:herovickers_github_io/widgets/work.dart';

class Body extends StatelessWidget {
  final BodyWidget currentBodyWidget;
  Body({
    Key key,
    @required this.currentBodyWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedCrossFade(
        crossFadeState: currentBodyWidget == BodyWidget.about
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 500),
        firstChild: About(),
        secondChild: Work(),
      ),
    );
  }
}