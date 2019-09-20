import 'package:flutter/material.dart';
import 'package:herovickers_github_io/data/app_constants.dart';

enum AppScreenSize {
  small,
  medium,
  large,
}

class AppFunctions {
  static _screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static AppScreenSize getScreenSize(BuildContext context) {
    var screenWidth = _screenWidth(context);

    AppScreenSize appScreen;

    if (screenWidth < AppConstants.SMALL_SCREEN_BREAKPOINT) {
      appScreen = AppScreenSize.small;
    } else if (screenWidth > AppConstants.SMALL_SCREEN_BREAKPOINT &&
        screenWidth < AppConstants.LARGE_SCREEN_BREAKPOINT) {
          appScreen = AppScreenSize.medium;
    } else {
      appScreen = AppScreenSize.large;
    }

    return appScreen;
  }
}
