import 'package:flutter/material.dart';
import 'package:music_flutter/colors/colors.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  MyAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        color: iconColor,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          color: iconColor,
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
