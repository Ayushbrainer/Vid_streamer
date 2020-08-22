//import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vid_streamer/AuthServices/Auth.dart';
import 'package:vid_streamer/AuthServices/SignInPage.dart';
import 'package:vid_streamer/Fav.dart';

//import 'package:video_player/video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

//import 'UI/PlayerUI.dart';
import 'UI/PlayerUI.dart';
import 'UI/VideoControllerUI.dart';

void main() => runApp(
      MaterialApp(
        home: SignIn(),
      ),
    );

class VidStrm extends StatefulWidget {
  @override
  _VidStrmState createState() => _VidStrmState();
}

class _VidStrmState extends State<VidStrm> {
  final _favourite = Set<VideoPlayerController>();
  @override
  VideoPlayerController _playerController;
  double _time = 0;
  bool isLiked = false;

  void initialize() async {
    _playerController = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    await _playerController.initialize();
    //await
  }

  void initState() {
    // TODO: implement initState
    initialize();
    _playerController.addListener(() {
      setState(() {
        _time = _playerController.value.position.inSeconds.toDouble();
      });
    });

    super.initState();
  }

  Widget listOfVideos() {
    bool plps = _playerController.value.isPlaying;
    final bool isLiked = _favourite.contains(_playerController);
    player(_playerController);
    return ListView.builder(
      itemBuilder: (context, i) {
        return Container(
          height: 300,
          //padding: EdgeInsets.symmetric(horizontal: 5.00,vertical: 10.00),
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 9),
          width: MediaQuery.of(context).size.width,
          color: Colors.black87,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  VidPlayer(context, _playerController, _time),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: FloatingActionButton(
                          onPressed: () {
                            (plps)
                                ? _playerController.pause()
                                : _playerController.play();
                          },
                          heroTag: "{$i+2}",
                          //backgroundColor: Colors.transparent,
                          child: (plps)
                              ? Icon(Icons.pause)
                              : Icon(Icons.play_arrow),
                        ),
                      ),
                      Flexible(
                        child: Slider(
                          value: _time,
                          onChanged: (v) {
                            _playerController
                                .seekTo(Duration(seconds: v.toInt()));
                          },
                          min: 0,
                          max: _playerController.value.duration.inSeconds
                              .toDouble(),
                        ),
                      ),
                      Flexible(
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              if (isLiked) {
                                _favourite.remove(_playerController);
                              } else {
                                _favourite.add(_playerController);
                              }
                            });
                          },
                          heroTag: "{$i+3}",
                          //backgroundColor: Colors.transparent,
                          child: (isLiked)
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                        ),
                      )
                    ],
                  ),
                  Flexible(
                      fit: FlexFit.loose,
                      flex: 4,
                      child: Text(
                        "TITLE OF THE VIDEO",
                        style: TextStyle(
                            fontSize: 10, color: Colors.lightBlueAccent),
                      )),
                  Flexible(
                      fit: FlexFit.loose,
                      flex: 4,
                      child: Text(
                        "description",
                        style: TextStyle(fontSize: 5, color: Colors.white30),
                      ))
                ],
              ),
            ],
          ),
        );
      },
      itemCount: 7,
    );
  }

  Widget player(VideoPlayerController _playerController) {
    bool plps = _playerController.value.isPlaying;
    final bool isLiked = _favourite.contains(_playerController);
    // return
  }

  Widget FavVid(BuildContext context, Set<VideoPlayerController> _controller,
      double time) {
    List<VideoPlayerController> _playerController = _controller.toList();
    return ListView.builder(
      itemBuilder: (context, i) {
        bool plps = _playerController[i].value.isPlaying;

        return Container(
            height: 300,
            //padding: EdgeInsets.symmetric(horizontal: 5.00,vertical: 10.00),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 9),
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flex(
                    direction: Axis.vertical,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      VidPlayer(context, _playerController[i], time),
                      Row(
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
                              heroTag: "{$i+1}",
                              //backgroundColor: Colors.transparent,
                              child: (plps)
                                  ? Icon(Icons.pause)
                                  : Icon(Icons.play_arrow),
                            ),
                          ),
                          Flexible(
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
                          Flexible(
                              fit: FlexFit.loose,
                              flex: 4,
                              child: Text(
                                "TITLE OF THE VIDEO",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.lightBlueAccent),
                              )),
                          Flexible(
                              fit: FlexFit.loose,
                              flex: 4,
                              child: Text(
                                "description",
                                style: TextStyle(
                                    fontSize: 5, color: Colors.white30),
                              ))
                        ],
                      ),
                    ],
                  ),
                ]));
      },
      itemCount: _playerController.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text("Video Streaming App"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Account Settings"),
            backgroundColor: Colors.white30,
          ),
          backgroundColor: Colors.black26,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.white,
              )),
              SizedBox(
                height: 60,
              ),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FavVid(context, _favourite, _time)));
                    });
                  },
                  child: Text("Favourites")),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.arrow_back),
                    Text("Log Out"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      body: (_playerController.value.initialized)
          ? listOfVideos()
          : Center(child: CircularProgressIndicator()),
    );
  }
}
