import 'package:flutter/material.dart';
import 'package:herovickers_github_io/utils/app_functions.dart';
import 'package:transparent_image/transparent_image.dart' as transparent_image;

class UserPicture extends StatelessWidget {
  const UserPicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: MemoryImage(transparent_image.kTransparentImage),
      image: NetworkImage(
        'assets/assets/images/selfie.jpg',
      ),
      height: AppFunctions.getScreenSize(context) == AppScreenSize.small
          ? null
          : 600,
    );
  }
}
