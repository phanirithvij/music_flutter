import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttery/gestures.dart';
import 'package:music_flutter/colors/colors.dart';
import 'package:music_flutter/components/circleclipper.dart';
import 'package:music_flutter/components/radialprogressbar.dart';

class RadialSeekBar extends StatefulWidget {
  final double seekPercent;
  final double progress;
  final Function(double) onSeekRequested;
  final Widget child;

  const RadialSeekBar({
    Key key,
    this.seekPercent = 0,
    this.progress = 0,
    this.onSeekRequested,
    this.child,
  }) : super(key: key);

  @override
  _RadialSeekBarState createState() => _RadialSeekBarState();
}

class _RadialSeekBarState extends State<RadialSeekBar> {
  double _progress;
  PolarCoord _startDragCoord;
  double _startDragPercent;
  double _currentDragPercent;

  void _onDragStart(PolarCoord startCoord) {
    _startDragCoord = startCoord;
    _startDragPercent = _progress;
    if (_progress == null) {
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
    if (widget.onSeekRequested != null) {
      widget.onSeekRequested(_currentDragPercent);
    }

    setState(() {
      // added this ?? check as it gave me an error sometimes
      // _progress = _currentDragPercent ?? _progress;
      _currentDragPercent = null;
      _startDragCoord = null;
      _startDragPercent = 0;
    });
    // print('Ondragend $_progress, $_currentDragPercent');
  }

  @override
  void didUpdateWidget(RadialSeekBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    _progress = widget.progress;
  }

  @override
  void initState() {
    super.initState();
    _progress = widget.progress;
  }

  @override
  Widget build(BuildContext context) {
    double thumbPosition = _progress;
    if (_currentDragPercent != null) {
      thumbPosition = _currentDragPercent;
    } else if (widget.seekPercent != null) {
      thumbPosition = widget.seekPercent;
    }

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
              progressPercent: _progress,
              thumbPosition: thumbPosition,
              innerPadding: EdgeInsets.all(2),
              child: ClipOval(
                clipper: CircleClipper(),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
