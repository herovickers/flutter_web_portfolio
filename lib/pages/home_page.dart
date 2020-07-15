import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:herovickers_github_io/data/app_colors.dart';
import 'package:herovickers_github_io/data/app_constants.dart';
import 'package:herovickers_github_io/data/app_dimens.dart';
import 'package:herovickers_github_io/widgets/body.dart';
import 'package:herovickers_github_io/widgets/footer.dart';
import 'package:herovickers_github_io/widgets/header.dart';
import 'package:herovickers_github_io/widgets/scroll_to_top_chevron.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum BodyWidget { about, work }

class _HomePageState extends State<HomePage> {
  AutoScrollController controller;
  int counter = 2;
  double chevronOpacity = 0.0;
  bool _showOverlayMenu = false;
  bool _isFooterCentered = false;
  BodyWidget _currentBodyWidget = BodyWidget.about;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
  }

  Future _scrollToFooter() async {
    if (_showOverlayMenu == true) {
      setState(() {
        _showOverlayMenu = false;
      });
    }
    await controller.scrollToIndex(counter,
        duration: Duration(seconds: 1),
        preferPosition: AutoScrollPosition.begin);
    controller.highlight(counter);
  }

  _scrollToTop() {
    controller.animateTo(controller.position.minScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }

  Widget _wrapScrollTag({int index, Widget child}) => AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );

  _toggleShowOverlayMenu(Key key) {
    setState(() {
      _showOverlayMenu = !_showOverlayMenu;
    });
  }

  _showAbout() {
    if (_currentBodyWidget != BodyWidget.about) {
      setState(() {
        _switchBodyToAbout();
        _unCenterFooter();
      });
    }
  }

  _switchBodyToAbout() {
    _currentBodyWidget = BodyWidget.about;
  }

  _unCenterFooter() {
    _isFooterCentered = false;
  }

  _showWork() {
    if (_currentBodyWidget != BodyWidget.work) {
      setState(() {
        _switchBodyToWork();
        _centerFooter();
      });
    }
  }

  _switchBodyToWork() {
    _currentBodyWidget = BodyWidget.work;
  }

  _centerFooter() {
    _isFooterCentered = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Scaffold(
        backgroundColor: AppColors.BACKGROUND_COLOR,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.SCREEN_PADDING_LEFT,
            0.0,
            AppDimens.SCREEN_PADDING_RIGHT,
            0.0,
          ),
          child: Container(
            child: Stack(
              children: <Widget>[
                AnimatedOpacity(
                    opacity: _showOverlayMenu ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 400),
                    child: SizedBox.expand(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Icon(
                        AntDesign.iconfontdesktop,
                        color: Colors.white.withOpacity(0.03),
                        size: MediaQuery.of(context).size.width / 1.5,
                      ),
                    ))),
                NotificationListener<ScrollNotification>(
                  onNotification: _handleScrollNotification,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      controller: controller,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: AppDimens.SCREEN_PADDING_TOP,
                            ),
                            Header(
                              onContactTap: _scrollToFooter,
                              onWorkTap: _showWork,
                              onMenuTap: _toggleShowOverlayMenu,
                              onAboutTap: _showAbout,
                            ),
                            SizedBox(height: 36.0),
                            AnimatedOpacity(
                                opacity: _showOverlayMenu ? 0.0 : 1.0,
                                duration: Duration(milliseconds: 500),
                                child: !_showOverlayMenu
                                    ? Column(
                                        children: <Widget>[
                                          Body(
                                              currentBodyWidget:
                                                  _currentBodyWidget),
                                          SizedBox(height: 36.0),
                                          _wrapScrollTag(
                                              index: counter,
                                              child: Footer(
                                                isFooterCentered:
                                                    _isFooterCentered,
                                              )),
                                          SizedBox(
                                            height:
                                                AppDimens.SCREEN_PADDING_BOTTOM,
                                          )
                                        ],
                                      )
                                    : Container())
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 16.0,
                  bottom: 16.0,
                  child: ScrollToTopChevron(
                    onPressed: _scrollToTop,
                    opacity: chevronOpacity,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.metrics.extentBefore < AppConstants.SCROLL_BEFORE_EXTENT) {
      setState(() {
        chevronOpacity = 0.0;
      });
    } else if (chevronOpacity != 0.5) {
      setState(() {
        chevronOpacity = 0.5;
      });
    }

    return false;
  }
}
