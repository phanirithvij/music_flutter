import 'package:flutter/material.dart';
import 'package:music_flutter/components/appbar.dart';
import 'package:music_flutter/components/audiodetails.dart';
import 'package:music_flutter/components/radialseekbar.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
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
    return Audio(
      audioUrl: demoPlaylist.songs[4].audioUrl,
      playbackState: PlaybackState.paused,
      child: Scaffold(
        appBar: MyAppBar(),
        body: Column(
          children: <Widget>[
            // round seek bar
            Expanded(
              child: RadialSeekBar(),
            ),

            // audio visualizer
            Container(
              width: double.infinity,
              height: 125,
            ),

            // audio details and controls
            AudioDetailsWidget(),
          ],
        ),
      ),
    );
  }
}

