import 'package:flutter/material.dart';

final demoPlaylist = PlayList(
  songs: [
    AudioModel(
      albumArtUrl:
          "https://i.scdn.co/image/e6a08e84fa0838f58b340e0d0e7e27213459d661",
      artists: [
        "Ed Sheeran",
        "Justin Beiber",
      ],
      audioUrl:
          "https://res.cloudinary.com/rootworld/video/upload/v1561913711/audios/I_Don_t_Care_CD_1_TRACK_1_320.mp3",
      songTitle: "I Don't Care (with Justin Bieber)",
    ),
    AudioModel(
      albumArtUrl:
          "https://i.scdn.co/image/1570007a6bf99b6f690ed7ddda59b94c9ba11152",
      artists: [
        "Ed Sheeran",
        "Chance the Rapper",
        "PnB Rock",
      ],
      audioUrl:
          "https://res.cloudinary.com/rootworld/video/upload/v1561913747/audios/Cross_Me_feat._Chance_the_Rapper_PnB_Rock_CD_1_TRACK_1.mp3",
      songTitle: "Cross Me (feat. Chance the Rapper & PnB Rock)",
    ),
    AudioModel(
      albumArtUrl:
          "https://i.scdn.co/image/170e1dee2677f32bdd400c4147eb527d84988d0e",
      artists: [
        "Bebe Rexha",
      ],
      audioUrl:
          "https://res.cloudinary.com/rootworld/video/upload/v1561913952/audios/Bebe_Rexha_I_m_a_Mess_320.mp3",
      songTitle: "I'm a Mess",
    ),
    AudioModel(
      albumArtUrl:
          "https://i.scdn.co/image/ae57b175f4e231814a63958ea13f939e1ec5aaa8",
      artists: [
        "Ellie Goulding",
        "Diplo",
        "Swae Lee",
      ],
      audioUrl:
          "https://res.cloudinary.com/rootworld/video/upload/v1561913964/audios/Ellie_Goulding_Diplo_Swae_Lee_Close_To_Me.mp3",
      songTitle: "Close To Me (with Diplo) (feat. Swae Lee)",
    ),
    AudioModel(
      albumArtUrl:
          "https://i.scdn.co/image/35cfbbed1566942d98dbad8867b7e316155512b8",
      artists: [
        "Big Z",
        "Jack Wilby",
      ],
      audioUrl:
          "https://res.cloudinary.com/rootworld/video/upload/v1561913947/audios/Big_Z_Jack_Wilby_This_Place_Unknown.mp3",
      songTitle: "This Place Unknown",
    ),
  ],
);

class PlayList {
  final List<AudioModel> songs;

  PlayList({@required this.songs});
}

class AudioModel {
  final String audioUrl;
  final String albumArtUrl;
  final String songTitle;
  final List<String> artists;

  AudioModel({
    @required this.audioUrl,
    @required this.albumArtUrl,
    @required this.songTitle,
    @required this.artists,
  });
}
