import 'package:flutter/material.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:music_flutter/colors/colors.dart';
import 'package:music_flutter/components/radialseekbar.dart';
import 'package:music_flutter/models/audio.dart';

class AudioRadialSeekBar extends StatefulWidget {
  final AudioModel audioModel;

  const AudioRadialSeekBar({
    Key key,
    this.audioModel,
  }) : super(key: key);

  @override
  _AudioRadialSeekBarState createState() => _AudioRadialSeekBarState();
}

class _AudioRadialSeekBarState extends State<AudioRadialSeekBar> {
  double _seekPercent;

  @override
  Widget build(BuildContext context) {
    return AudioComponent(
      updateMe: [
        WatchableAudioProperties.audioPlayhead,
        WatchableAudioProperties.audioSeeking,
      ],
      playerBuilder: (context, player, child) {
        double playbackProgress = 0;

        if (player.audioLength != null && player.position != null) {
          playbackProgress = player.position.inMilliseconds /
              player.audioLength.inMilliseconds;
        }

        _seekPercent = player.isSeeking ? _seekPercent : null;

        return RadialSeekBar(
          progress: playbackProgress,
          seekPercent: _seekPercent,
          child : Container(
            color: accentColor,
            child: Image.network(
              widget.audioModel.albumArtUrl,
              fit: BoxFit.cover,
            ),
          ),
          onSeekRequested: (seekPercent) {
            setState(() {
              _seekPercent = seekPercent;
            });

            final seekMillis =
                (player.audioLength.inMilliseconds * seekPercent).round();
            player.seek(Duration(milliseconds: seekMillis));
          },
        );
      },
    );
  }
}
