import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:herovickers_github_io/data/app_colors.dart';
import 'package:herovickers_github_io/data/app_constants.dart';
import 'package:herovickers_github_io/data/app_dimens.dart';
import 'package:herovickers_github_io/data/app_strings.dart';
import 'package:herovickers_github_io/data/widget_keys.dart';
import 'package:herovickers_github_io/utils/app_functions.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
// ignore: uri_does_not_exist
import 'dart:html' as html;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AutoScrollController controller;
  int counter = 2;
  double chevronOpacity = 0.0;
  bool _showOverlayMenu = false;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
  }

  Future _scrollToFooter(Key key) async {
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
                                onMenuTap: _toggleShowOverlayMenu),
                            SizedBox(height: 36.0),
                            AnimatedOpacity(
                                opacity: _showOverlayMenu ? 0.0 : 1.0,
                                duration: Duration(milliseconds: 500),
                                child: !_showOverlayMenu
                                    ? Column(
                                        children: <Widget>[
                                          Body(),
                                          SizedBox(height: 36.0),
                                          _wrapScrollTag(
                                              index: counter, child: Footer()),
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
                  child: AnimatedOpacity(
                    duration: Duration(
                      seconds: 1,
                    ),
                    opacity: chevronOpacity,
                    child: Material(
                      shape: CircleBorder(),
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: _scrollToTop,
                        iconSize: 96.0,
                        icon: Icon(
                          EvilIcons.chevron_up, //Icons.arrow_upward,
                          color: AppColors.WHITE_DARK,
                        ),
                      ),
                    ),
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

class Footer extends StatelessWidget {
  Footer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FractionallySizedBox(
          widthFactor:
              AppFunctions.getScreenSize(context) == AppScreenSize.small
                  ? 1
                  : 2 / 5,
          child: FooterMessage(),
        ),
        SizedBox(
          height: 24.0,
        ),
        EmailButton(),
        SizedBox(
          height: 18.0,
        ),
        Socials(),
      ],
    );
  }
}

class FooterMessage extends StatelessWidget {
  const FooterMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.FOOTER_MESSAGE,
      style: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontFamily: 'PlayfairDisplay-Regular'),
    );
  }
}

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
              'mailto: enderwiggins003@gmail.com?subject=Hello!&body=Hi,%20Victor',
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

class Socials extends StatelessWidget {
  const Socials({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      buildSocialIconButton(MaterialCommunityIcons.github_circle,
          url: AppStrings.GITHUB_URL),
      buildSocialIconButton(MaterialCommunityIcons.stack_overflow,
          url: AppStrings.STACKOVERFLOW_URL),
      buildSocialIconButton(MaterialCommunityIcons.twitter,
          url: AppStrings.TWITTER_URL),
    ]);
  }

  Widget buildSocialIconButton(IconData icon, {@required url}) {
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

class Body extends StatelessWidget {
  Body({
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
              child: BodyDetails(),
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
                      child: Picture(),
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
                    child: Picture(),
                  ),
                ))
      ],
    );
  }
}

class Picture extends StatelessWidget {
  const Picture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: NetworkImage(
        'assets/assets/images/photo_grey_compressed.jpg',
      ),
      image: NetworkImage(
        'assets/assets/images/photo_grey.png',
      ),
      height: AppFunctions.getScreenSize(context) == AppScreenSize.small
          ? null
          : 600,
    );
  }
}

class BodyDetails extends StatelessWidget {
  const BodyDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          AppStrings.FULL_NAME,
          style: TextStyle(
              color: Colors.white,
              fontSize: 48.0,
              fontFamily: 'PlayfairDisplaySC-Regular'),
        ),
        SizedBox(
          height: 32.0,
        ),
        RichText(
          text: TextSpan(
              style: TextStyle(
                fontSize: 34.0,
              ),
              children: AppStrings.BODY_SUMMARY.split(' ').map(
                (string) {
                  return TextSpan(
                      text: string + ' ',
                      style: TextStyle(
                          color: AppStrings.BOLDED_STRINGS.contains(string)
                              ? AppColors.PRIMARY
                              : AppColors.WHITE_DARK,
                          fontSize: 36,
                          fontFamily: 'PlayfairDisplay-Regular'));
                },
              ).toList()),
        ),
        SizedBox(
          height: 32.0,
        ),
        Text(
          AppStrings.BODY_MESSAGE,
          style: TextStyle(
              fontSize: 24.0,
              color: AppColors.WHITE_DARK,
              fontFamily: 'SourceSansPro-ExtraLight'),
        ),
      ],
    );
  }
}

class Header extends StatefulWidget {
  final Future Function(Key key) onContactTap;
  final Function(Key key) onMenuTap;

  const Header({
    Key key,
    @required this.onContactTap,
    this.onMenuTap,
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _showLargeMenu = false;
  Key _selectedWidgetKey = WidgetKeys.DEFAULT_SELECTED_HEADER_KEY;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _changeSelectedHeader(Key key) {
    setState(() {
      _selectedWidgetKey = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppScreenSize appScreenSize = AppFunctions.getScreenSize(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              AppStrings.TITLE,
              style:
                  TextStyle(fontSize: 24.0, fontFamily: 'SourceSansPro-Light'),
            ),
            appScreenSize == AppScreenSize.large
                ? Row(
                    children: <Widget>[
                      HeaderItem(
                        AppStrings.WORK,
                        key: WidgetKeys.WORK_WIDGET_KEY,
                        selectedWidgetKey: _selectedWidgetKey,
                        onTap: (Key key) => _changeSelectedHeader(key),
                      ),
                      HeaderItem(
                        AppStrings.ABOUT,
                        key: WidgetKeys.ABOUT_WIDGET_KEY,
                        selectedWidgetKey: _selectedWidgetKey,
                        onTap: (Key key) => _changeSelectedHeader(key),
                      ),
                      HeaderItem(
                        AppStrings.CONTACT,
                        key: WidgetKeys.CONTACT_WIDGET_KEY,
                        onTap: (Key key) {
                          _toggleMenu();
                          return widget.onContactTap(key);
                        },
                        selectedWidgetKey: _selectedWidgetKey,
                      )
                    ],
                  )
                : IconButton(
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: _animationController,
                      semanticLabel: 'Show menu',
                      color: AppColors.WHITE,
                    ),
                    onPressed: () {
                      _toggleMenu();
                    },
                  )
          ],
        ),
        appScreenSize == AppScreenSize.large
            ? Container()
            : Flexible(
                fit: FlexFit.loose,
                child: AnimatedOpacity(
                  opacity: _showLargeMenu ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    height: _showLargeMenu
                        ? MediaQuery.of(context).size.height -
                            AppDimens.SCREEN_PADDING_TOP -
                            AppDimens.SCREEN_PADDING_BOTTOM -
                            36.0
                        : 0.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        HeaderItem(
                          AppStrings.WORK,
                          key: WidgetKeys.WORK_WIDGET_KEY,
                          selectedWidgetKey: _selectedWidgetKey,
                          onTap: (Key key) => _changeSelectedHeader(key),
                        ),
                        HeaderItem(
                          AppStrings.ABOUT,
                          key: WidgetKeys.ABOUT_WIDGET_KEY,
                          selectedWidgetKey: _selectedWidgetKey,
                          onTap: (Key key) => _changeSelectedHeader(key),
                        ),
                        HeaderItem(
                          AppStrings.CONTACT,
                          key: WidgetKeys.CONTACT_WIDGET_KEY,
                          onTap: (Key key) {
                            _toggleMenu();
                            return widget.onContactTap(key);
                          },
                          selectedWidgetKey: _selectedWidgetKey,
                        )
                      ],
                    ),
                  ),
                ),
              )
      ],
    );
  }

  void _toggleMenu() {
    setState(() {
      _showLargeMenu = !_showLargeMenu;
    });

    _animationController.status == AnimationStatus.completed
        ? _animationController.reverse()
        : _animationController.forward();
    widget.onMenuTap(_selectedWidgetKey);
  }
}

class HeaderItem extends StatelessWidget {
  final String headerItemString;
  final Future<dynamic> Function(Key) onTap;
  final bool showMenuOverlay;
  final Key selectedWidgetKey;

  HeaderItem(
    this.headerItemString, {
    @required Key key,
    @required this.onTap,
    this.showMenuOverlay = false,
    @required this.selectedWidgetKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = Colors.white;
    bool isSelected = selectedWidgetKey == key;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
        ),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return MouseRegion(
            onEnter: (pointerHoverEvent) {
              setState(() {
                textColor = AppColors.PRIMARY;
              });
            },
            onExit: (pointerHoverEvent) {
              setState(() {
                textColor = AppColors.WHITE;
              });
            },
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isSelected = true;
                  });

                  if (onTap != null) onTap(key);
                },
                child: Text(
                  headerItemString,
                  style: TextStyle(
                      fontSize: showMenuOverlay ? 24.0 : 32.0,
                      color: isSelected ? AppColors.PRIMARY : textColor,
                      fontFamily: 'SourceSansPro-ExtraLight'),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
