import 'package:flutter/material.dart';
import 'package:music_flutter/components/appbar.dart';
import 'package:music_flutter/components/audiodetails.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:music_flutter/components/audioradialseekbar.dart';
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
    return AudioPlaylist(
      playlist: demoPlaylist.songs.map((f) => f.audioUrl).toList(),
      playbackState: PlaybackState.paused,
      child: Scaffold(
        appBar: MyAppBar(),
        body: Column(
          children: <Widget>[
            // round seek bar
            Expanded(
              child: AudioPlaylistComponent(
                playlistBuilder: (context, playlist, child) {
                  var audio = demoPlaylist.songs[playlist.activeIndex];
                  return AudioRadialSeekBar(
                    audioModel: audio,
                  );
                },
              ),
            ),

            // audio visualizer
            Container(
              width: double.infinity,
              height: 125,
            ),

            // audio details and controls
            AudioPlaylistComponent(
              playlistBuilder: (context, playlist, child) {
                var audio = demoPlaylist.songs[playlist.activeIndex];
                return AudioDetailsWidget(
                  audioModel: audio,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
