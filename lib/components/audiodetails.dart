import 'package:flutter/material.dart';
import 'package:music_flutter/colors/colors.dart';
import 'package:music_flutter/components/controls.dart';
import 'package:music_flutter/models/audio.dart';

class AudioDetailsWidget extends StatelessWidget {
  final AudioModel audioModel;

  const AudioDetailsWidget({
    Key key,
    this.audioModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Material(
        color: accentColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 50),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: '',
                          children: [
                            TextSpan(
                              text: '${audioModel.songTitle}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: audioModel.artists.join(', '),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 12,
                            letterSpacing: 3,
                            height: 1.5,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // controls
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 40),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    PrevButton(),
                    Expanded(
                      child: Container(),
                    ),
                    PlayPauseButton(),
                    Expanded(
                      child: Container(),
                    ),
                    NextButton(),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
