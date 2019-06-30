import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttery/gestures.dart';
import 'package:music_flutter/colors/colors.dart';
import 'package:music_flutter/components/appbar.dart';
import 'package:music_flutter/components/audiodetails.dart';
import 'package:music_flutter/components/circleclipper.dart';
import 'package:music_flutter/models/audio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Flutter',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: <Widget>[
          // round seek bar
          RadialSeekWidget(),
          // RandomColorBlock(
          //   width: double.infinity,
          //   height: 100,
          // ),

          // visualizer
          Container(
            width: double.infinity,
            height: 125,
          ),

          // audio details
          AudioDetailsWidget(),
        ],
      ),
    );
  }
}

class RadialSeekWidget extends StatefulWidget {
  const RadialSeekWidget({
    Key key,
  }) : super(key: key);

  @override
  _RadialSeekWidgetState createState() => _RadialSeekWidgetState();
}

class _RadialSeekWidgetState extends State<RadialSeekWidget> {
  double _seekPercent;
  PolarCoord _startDragCoord;
  double _startDragPercent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _seekPercent = 0.3;
    return Expanded(
      child: RadialDragGestureDetector(
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
                thumbPosition: _seekPercent,
                progressPercent: _seekPercent,
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
      ),
    );
  }

  void _onDragUpdate(PolarCoord updateCoord) {}

  void _onDragStart(PolarCoord startCoord) {}

  void _onDragEnd() {}
}

class RadialProgressBar extends StatefulWidget {
  final Widget child;
  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final Color progressColor;
  final double thumbSize;
  final Color thumbColor;
  final double progressPercent;
  final double thumbPosition;
  final EdgeInsets outerPadding;
  final EdgeInsets innerPadding;

  RadialProgressBar({
    Key key,
    this.child,
    this.thumbSize = 6,
    this.trackWidth = 3,
    this.progressWidth = 4,
    this.thumbPosition = 0.0,
    this.progressPercent = 0.0,
    this.trackColor = Colors.grey,
    this.thumbColor = Colors.black,
    this.progressColor = Colors.black,
    this.outerPadding = const EdgeInsets.all(0),
    this.innerPadding = const EdgeInsets.all(0),
  }) : super(key: key);

  _RadialProgressBarState createState() => _RadialProgressBarState();
}

class _RadialProgressBarState extends State<RadialProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.outerPadding,
      child: CustomPaint(
        foregroundPainter: RadialProgressBarPainter(
          progressPercent: widget.progressPercent,
          progressWidth: widget.progressWidth,
          thumbSize: widget.thumbSize,
          thumbPosition: widget.thumbPosition,
          thumbColor: widget.thumbColor,
          trackWidth: widget.trackWidth,
          trackColor: widget.trackColor,
          progressColor: widget.progressColor,
        ),
        child: Padding(
          padding: _insetsForPainter() + widget.innerPadding,
          child: widget.child,
        ),
      ),
    );
  }

  EdgeInsets _insetsForPainter() {
    final outerThickness = max(
          widget.trackWidth,
          max(
            widget.progressWidth,
            widget.thumbSize,
          ),
        ) /
        2;

    return EdgeInsets.all(outerThickness);
  }
}

class RadialProgressBarPainter extends CustomPainter {
  final double trackWidth;
  final Paint trackPaint;
  final double progressWidth;
  final Paint progessPaint;
  final double progressPercent;
  final double thumbSize;
  final double thumbPosition;
  final Paint thumbPaint;

  RadialProgressBarPainter({
    @required this.thumbSize,
    @required this.trackWidth,
    @required this.progressWidth,
    @required this.thumbPosition,
    @required this.progressPercent,
    @required trackColor,
    @required thumbColor,
    @required progressColor,
  })  : trackPaint = Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth,
        progessPaint = Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWidth
          ..strokeCap = StrokeCap.round,
        thumbPaint = Paint()
          ..color = thumbColor
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final outerThickness = max(
      trackWidth,
      max(
        progressWidth,
        thumbSize,
      ),
    );
    Size constrainedSize = Size(
      size.width - outerThickness,
      size.height - outerThickness,
    );

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(constrainedSize.width, constrainedSize.height) / 2;

    // track painter
    canvas.drawCircle(center, radius, trackPaint);

    // paint progress

    final progressAngle = 2 * pi * progressPercent;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -pi / 2,
      progressAngle,
      false,
      progessPaint,
    );

    // paint thumb
    final thumbAngle = 2 * pi * thumbPosition - (pi / 2);
    final thumbX = cos(thumbAngle) * radius;
    final thumbY = sin(thumbAngle) * radius;
    final thumbCenter = Offset(thumbX, thumbY) + center;
    final thumbRadius = thumbSize;

    canvas.drawCircle(
      thumbCenter,
      thumbRadius,
      thumbPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
