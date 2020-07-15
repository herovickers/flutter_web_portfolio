
import 'package:flutter/material.dart';
import 'package:herovickers_github_io/data/app_colors.dart';
import 'package:herovickers_github_io/data/app_dimens.dart';
import 'package:herovickers_github_io/data/app_strings.dart';
import 'package:herovickers_github_io/data/widget_keys.dart';
import 'package:herovickers_github_io/utils/app_functions.dart';
import 'package:herovickers_github_io/widgets/header_item.dart';

class Header extends StatefulWidget {
  final Future Function() onContactTap;
  final Function(Key key) onMenuTap;
  final Function() onWorkTap;
  final Function() onAboutTap;

  const Header({
    Key key,
    @required this.onContactTap,
    @required this.onMenuTap,
    @required this.onWorkTap,
    @required this.onAboutTap,
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _showLargeMenu = false;
  Key _selectedWidgetKey = WidgetKeys.DEFAULT_SELECTED_HEADER_KEY;
  List<HeaderItem> headerItemList = [];
  Color _titleColor = AppColors.WHITE;

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
    headerItemList = [
      HeaderItem(
        AppStrings.WORK,
        key: WidgetKeys.WORK_WIDGET_KEY,
        selectedWidgetKey: _selectedWidgetKey,
        onTap: (Key key) {
          return _onWorkHeaderTap(key);
        },
      ),
      HeaderItem(
        AppStrings.ABOUT,
        key: WidgetKeys.ABOUT_WIDGET_KEY,
        selectedWidgetKey: _selectedWidgetKey,
        onTap: (Key key) {
          return _onAboutHeaderTap(key);
        },
      ),
      HeaderItem(
        AppStrings.CONTACT,
        key: WidgetKeys.CONTACT_WIDGET_KEY,
        onTap: (Key key) {
          return _onContactHeaderTap();
        },
        selectedWidgetKey: _selectedWidgetKey,
      )
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MouseRegion(
              onEnter: (pointerHoverEvent) {
                setState(() {
                  _titleColor = AppColors.PRIMARY;
                });
              },
              onExit: (pointerHoverEvent) {
                setState(() {
                  _titleColor = AppColors.WHITE;
                });
              },
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _onAboutHeaderTap(WidgetKeys.ABOUT_WIDGET_KEY);
                  },
                  child: Text(
                    AppStrings.TITLE,
                    style: TextStyle(
                        color: _titleColor,
                        fontSize: 24.0,
                        fontFamily: 'SourceSansPro-Light'),
                  ),
                ),
              ),
            ),
            appScreenSize == AppScreenSize.large
                ? Row(
                    children: <Widget>[
                      ...headerItemList,
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
                        ...headerItemList,
                      ],
                    ),
                  ),
                ),
              )
      ],
    );
  }

  _onWorkHeaderTap(Key key) {
    if (_showLargeMenu) _toggleMenu();
    widget.onWorkTap();
    return _changeSelectedHeader(key);
  }

  Future _onContactHeaderTap() {
    if (_showLargeMenu) _toggleMenu();
    return widget.onContactTap();
  }

  _onAboutHeaderTap(Key key) {
    if (_showLargeMenu) _toggleMenu();
    widget.onAboutTap();
    return _changeSelectedHeader(key);
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
