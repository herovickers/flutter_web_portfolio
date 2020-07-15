import 'package:flutter/material.dart';
import 'package:herovickers_github_io/utils/app_functions.dart';

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