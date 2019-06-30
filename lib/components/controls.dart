import 'package:flutter/material.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:music_flutter/colors/colors.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AudioComponent(
      updateMe: [
        WatchableAudioProperties.audioPlayerState,
      ],
      playerBuilder: (context, player, child) {
        IconData icon = Icons.music_note;
        Function onPressed;
        Color buttonColor = lightAccentColor;

        if (player.state == AudioPlayerState.playing) {
          icon = Icons.pause;
          onPressed = player.pause;
          buttonColor = Colors.white;
        } else if (player.state == AudioPlayerState.paused ||
            player.state == AudioPlayerState.completed) {
          icon = Icons.play_arrow;
          onPressed = player.play;
          buttonColor = Colors.white;
        }

        return RawMaterialButton(
          shape: CircleBorder(),
          onPressed: onPressed,
          fillColor: buttonColor,
          splashColor: lightAccentColor,
          highlightColor: darkAccentColor.withOpacity(0.5),
          elevation: 10,
          highlightElevation: 5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              icon,
              color: darkAccentColor,
              size: 35,
            ),
          ),
        );
      },
    );
  }
}

class PrevButton extends StatelessWidget {
  const PrevButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AudioPlaylistComponent(
      playlistBuilder: (context, playlist, child) {
        var current = playlist.activeIndex;
        return IconButton(
          splashColor: lightAccentColor,
          highlightColor: Colors.transparent,
          color: current != 0 ? Colors.white : lightAccentColor,
          icon: Icon(
            Icons.skip_previous,
            size: 35,
          ),
          onPressed: playlist.previous,
        );
      },
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AudioPlaylistComponent(
      playlistBuilder: (context, playlist, child) {
        // var last = playlist.son
        return IconButton(
          splashColor: lightAccentColor,
          highlightColor: Colors.transparent,
          color: Colors.white,
          icon: Icon(
            Icons.skip_next,
            size: 35,
          ),
          onPressed: playlist.next,
        );
      },
    );
  }
}
