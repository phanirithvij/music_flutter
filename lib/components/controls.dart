import 'package:flutter/material.dart';
import 'package:music_flutter/colors/colors.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      onPressed: () {},
      fillColor: Colors.white,
      splashColor: lightAccentColor,
      highlightColor: darkAccentColor.withOpacity(0.5),
      elevation: 10,
      highlightElevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.play_arrow,
          color: darkAccentColor,
          size: 35,
        ),
      ),
    );
  }
}

class PrevButton extends StatelessWidget {
  const PrevButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      color: Colors.white,
      icon: Icon(
        Icons.skip_previous,
        size: 35,
      ),
      onPressed: () {},
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      color: Colors.white,
      icon: Icon(
        Icons.skip_next,
        size: 35,
      ),
      onPressed: () {},
    );
  }
}
