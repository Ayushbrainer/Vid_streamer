import 'dart:ffi';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
//import 'package:video_streamer/UI/VideoControllerUI.dart';

Widget VidPlayer(BuildContext context, VideoPlayerController _playerController,
    double _time) {
  Flexible f = Flexible(
    fit: FlexFit.loose,
    child: Column(
      children: <Widget>[
        Center(
          child: Container(
            height: 200,
            padding: EdgeInsets.all(5.0),
            child: AspectRatio(
              aspectRatio: _playerController.value.aspectRatio * 3,
              child: VideoPlayer(_playerController),
            ),
          ),
        ),
        // VidPlayerController(_playerController, _time)
        //VideoPlayer(_playerController),
      ],
    ),
  );

  return f;
}
