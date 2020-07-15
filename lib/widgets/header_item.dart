
import 'package:flutter/material.dart';
import 'package:herovickers_github_io/data/app_colors.dart';

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
