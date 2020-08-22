import 'package:flutter/material.dart';
import 'package:vid_streamer/UI/PlayerUI.dart';
import 'package:video_player/video_player.dart';

Material VideoPlayerFav(Set<dynamic> _set, BuildContext context, double time) {
  Widget FavVid() {
    List<VideoPlayerController> _playerController = _set.toList();
    return Material(
      child: Scaffold(
        body: ListView.builder(
          itemBuilder: (context, i) {
            bool plps = _playerController[i].value.isPlaying;
            return Container(
                height: 300,
                //padding: EdgeInsets.symmetric(horizontal: 5.00,vertical: 10.00),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 9),
                width: MediaQuery.of(context).size.width,
                color: Colors.black87,
                child: ListView(children: <Widget>[
                  Flex(
                    direction: Axis.vertical,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      VidPlayer(context, _playerController[i], time),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: FloatingActionButton(
                                onPressed: () {
                                  (plps)
                                      ? _playerController[i].pause()
                                      : _playerController[i].play();
                                },
                                heroTag: "{$i}",
                                //backgroundColor: Colors.transparent,
                                child: (plps)
                                    ? Icon(Icons.pause)
                                    : Icon(Icons.play_arrow),
                              ),
                            ),
                            Flexible(
                              child: Card(
                                child: Slider(
                                  value: time,
                                  onChanged: (v) {
                                    _playerController[i]
                                        .seekTo(Duration(seconds: v.toInt()));
                                  },
                                  min: 0,
                                  max: _playerController[i]
                                      .value
                                      .duration
                                      .inSeconds
                                      .toDouble(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]));
          },
          itemCount: _playerController.length,
        ),
      ),
    );
  }

  Material p = Material(
    child: FavVid(),
  );

  return p;
}
