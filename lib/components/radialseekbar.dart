import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttery/gestures.dart';
import 'package:music_flutter/colors/colors.dart';
import 'package:music_flutter/components/circleclipper.dart';
import 'package:music_flutter/components/radialprogressbar.dart';
import 'package:music_flutter/models/audio.dart';

class RadialSeekBar extends StatefulWidget {
  final double seekPercent;

  const RadialSeekBar({
    Key key,
    this.seekPercent = 0,
  }) : super(key: key);

  @override
  _RadialSeekBarState createState() => _RadialSeekBarState();
}

class _RadialSeekBarState extends State<RadialSeekBar> {
  double _seekPercent;
  PolarCoord _startDragCoord;
  double _startDragPercent;
  double _currentDragPercent;

  void _onDragStart(PolarCoord startCoord) {
    _startDragCoord = startCoord;
    _startDragPercent = _seekPercent;
    if (_seekPercent == null) {
      print('seek percent is null');
    }
  }

  void _onDragUpdate(PolarCoord updateCoord) {
    final dragAngle = updateCoord.angle - _startDragCoord.angle;
    final dragPercent = dragAngle / 2 * pi;

    setState(() {
      if (_startDragPercent != null && dragPercent != null)
        _currentDragPercent = (_startDragPercent + dragPercent) % 1.0;
    });
  }

  void _onDragEnd() {
    setState(() {
      // added this ?? check as it gave me an error sometimes
      _seekPercent = _currentDragPercent ?? _seekPercent;
      _currentDragPercent = null;
      _startDragCoord = null;
      _startDragPercent = 0;
    });
    // print('Ondragend $_seekPercent, $_currentDragPercent');
  }

  @override
  void didUpdateWidget(RadialSeekBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    _seekPercent = widget.seekPercent;
  }

  @override
  void initState() {
    super.initState();
    _seekPercent = widget.seekPercent;
  }

  @override
  Widget build(BuildContext context) {
    return RadialDragGestureDetector(
      onRadialDragEnd: _onDragEnd,
      onRadialDragStart: _onDragStart,
      onRadialDragUpdate: _onDragUpdate,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 140,
            height: 140,
            // color: Colors.green,
            child: RadialProgressBar(
              trackColor: Color(0xFFDDDDDD),
              progressColor: accentColor,
              thumbColor: lightAccentColor,
              progressPercent: _currentDragPercent ?? _seekPercent,
              thumbPosition: _currentDragPercent ?? _seekPercent,
              innerPadding: EdgeInsets.all(2),
              child: ClipOval(
                clipper: CircleClipper(),
                child: Image.network(
                  demoPlaylist.songs[4].albumArtUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

