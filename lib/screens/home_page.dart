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

enum BodyWidget { about, work }

class _MyHomePageState extends State<MyHomePage> {
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
    setState(() {
      _switchBodyToAbout();
      _unCenterFooter();
    });
  }

  _switchBodyToAbout() {
    _currentBodyWidget = BodyWidget.about;
  }

  _unCenterFooter() {
    _isFooterCentered = false;
  }

  _showWork() {
    setState(() {
      _switchBodyToWork();
      _centerFooter();
    });
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
  final bool isFooterCentered;
  const Socials({Key key, @required this.isFooterCentered}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFooterCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: <Widget>[
        SocialIconButton(
            icon: MaterialCommunityIcons.github_circle,
            url: AppStrings.GITHUB_URL),
        SocialIconButton(
            icon: MaterialCommunityIcons.stack_overflow,
            url: AppStrings.STACKOVERFLOW_URL),
        SocialIconButton(
            icon: MaterialCommunityIcons.twitter, url: AppStrings.TWITTER_URL),
      ],
    );
  }
}

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

class Work extends StatelessWidget {
  const Work({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 100.0, top: 50.0),
      child: Column(
        children: <Widget>[
          Text(
            AppStrings.WORK,
            style: TextStyle(
                color: AppColors.PRIMARY,
                fontSize: 48.0,
                fontFamily: 'PlayfairDisplaySC-Regular'),
          ),
          SizedBox(
            height: 100.0,
          ),
          WorkItem(
            imagePath: 'assets/assets/images/world_holidays.png',
            title: 'World Holidays',
            description:
                'World Holidays is a mobile app that displays the various holidays in a year across the countries of the world and reminds you of your favourite holidays.',
            playStoreLink:
                'https://play.google.com/store/apps/details?id=app.outfitbattle',
            githubLink: 'https://github.com/herovickers/world_holidays',
            index: 0, //TODO Reorganize code and remove this... index
          ),
          SizedBox(
            height: 75.0,
          ),
          FractionallySizedBox(
            widthFactor: 1.0,
            child: Container(
              height: 0.5,
              color: AppColors.WHITE_DARK,
              width: 500.0,
            ),
          ),
          SizedBox(
            height: 75.0,
          ),
          WorkItem(
            imagePath: 'assets/assets/images/tag_battle.png',
            title: 'Tag Battle',
            description:
                'Tag battle is an app that combines social media and gaming taking competition to a new level. It makes use of hashtags to organize for battles for users to vote and earn rewards!',
            playStoreLink:
                'https://play.google.com/store/apps/details?id=app.outfitbattle',
            index: 1,
          ),
        ],
      ),
    );
  }
}

class WorkItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String playStoreLink;
  final String appStoreLink;
  final String githubLink;
  final int index;

  const WorkItem(
      {Key key,
      @required this.imagePath,
      @required this.title,
      @required this.description,
      @required this.index,
      this.appStoreLink = '',
      this.playStoreLink = '',
      this.githubLink = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppScreenSize appScreenSize = AppFunctions.getScreenSize(context);

    return Flex(
      direction: appScreenSize == AppScreenSize.small
          ? Axis.vertical
          : Axis.horizontal,
      textDirection: index.isEven ? TextDirection.ltr : TextDirection.rtl,
      children: <Widget>[
        appScreenSize == AppScreenSize.small
            ? _buildAppImage()
            : Expanded(
                child: _buildAppImage(),
              ),
        SizedBox(
          width: 50.0,
          height: 30.0,
        ),
        appScreenSize == AppScreenSize.small
            ? _buildAppDetails()
            : Expanded(
                child: _buildAppDetails(),
              ),
      ],
    );
  }

  Widget _buildAppImage() => Image.network(imagePath);

  Column _buildAppDetails() {
    return Column(
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.WHITE_DARK,
              fontSize: 36,
              fontFamily: 'PlayfairDisplay-Regular'),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          description,
          style: TextStyle(
              fontSize: 24.0,
              color: AppColors.WHITE_DARK,
              fontFamily: 'SourceSansPro-ExtraLight'),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            playStoreLink.isNotEmpty
                ? SocialIconButton(
                    icon: MaterialCommunityIcons.google_play,
                    url: playStoreLink,
                  )
                : Container(),
            githubLink.isNotEmpty
                ? SocialIconButton(
                    icon: MaterialCommunityIcons.github_circle,
                    url: githubLink,
                  )
                : Container(),
            appStoreLink.isNotEmpty
                ? SocialIconButton(
                    icon: Fontisto.app_store,
                    url: appStoreLink,
                  )
                : Container()
          ],
        )
      ],
    );
  }
}

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

class UserPicture extends StatelessWidget {
  const UserPicture({
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

class AboutDetails extends StatelessWidget {
  const AboutDetails({
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
          if (_showLargeMenu) _toggleMenu();
          widget.onWorkTap();
          return _changeSelectedHeader(key);
        },
      ),
      HeaderItem(
        AppStrings.ABOUT,
        key: WidgetKeys.ABOUT_WIDGET_KEY,
        selectedWidgetKey: _selectedWidgetKey,
        onTap: (Key key) {
          if (_showLargeMenu) _toggleMenu();
          widget.onAboutTap();
          return _changeSelectedHeader(key);
        },
      ),
      HeaderItem(
        AppStrings.CONTACT,
        key: WidgetKeys.CONTACT_WIDGET_KEY,
        onTap: (Key key) {
          _toggleMenu();
          return widget.onContactTap();
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
            Text(
              AppStrings.TITLE,
              style:
                  TextStyle(fontSize: 24.0, fontFamily: 'SourceSansPro-Light'),
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
    bool isSelected = selectedWidgetKey ==
        key; //TODO Remove unnecessary passing of key to HeaderItem

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
