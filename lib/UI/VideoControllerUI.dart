import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_reactive_button/flutter_reactive_button.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

//VideoPlayerController _playerController;

Widget VidPlayerController(VideoPlayerController Vidcon, double time) {
  bool isLiked = false;
  bool plps = Vidcon.value.isPlaying;
  Row r = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Flexible(
        child: FloatingActionButton(
          onPressed: () {
            (plps) ? Vidcon.pause() : Vidcon.play();
          },
          //backgroundColor: Colors.transparent,
          child: (plps) ? Icon(Icons.pause) : Icon(Icons.play_arrow),
        ),
      ),
      Flexible(
        child: Slider(
          value: time,
          onChanged: (v) {
            Vidcon.seekTo(Duration(seconds: v.toInt()));
          },
          min: 0,
          max: Vidcon.value.duration.inSeconds.toDouble(),
        ),
      ),
      Flexible(
        child: FloatingActionButton(
          onPressed: () {
            (isLiked) ? isLiked = false : isLiked = true;
          },
          //backgroundColor: Colors.transparent,
          child: (isLiked)
              ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
        ),
      )
    ],
  );

  return r;
}
