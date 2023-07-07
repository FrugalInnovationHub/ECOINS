import 'dart:async';

import 'package:ecoins/game.dart';
import 'package:ecoins/screens/pause_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(
      'assets/videos/video1.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize().then((value) =>  setState(() { _controller.play(); }) );

    // Use the controller to loop the video.
    // _controller.setLooping(true);

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isVisible = true;
      });
    });

    _controller.addListener(() {                       //custom Listner
      setState(() {
        if (!_controller.value.isPlaying && _controller.value.isInitialized &&
            (_controller.value.duration ==_controller.value.position)) {//checking the duration and position every time
          // Navigator.pushReplacementNamed(this.context, '/game');
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context) => GameWidget(
                game: EcoinsGame(context: context),
                overlayBuilderMap: {
                  'PauseMenu':
                      (BuildContext context, EcoinsGame game) {
                    return pause_menu(game: game);
                  }
                }
            ),
          ));
        }
      });
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return VideoPlayer(_controller);
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
              visible: _isVisible,
              child: FloatingActionButton(
                heroTag: "Skip",
                tooltip: "Skip",
                onPressed: () {
                  // Wrap the play or pause in a call to `setState`. This ensures the
                  // correct icon is shown.
                  setState(() {
                    // If the video is playing, pause it.
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    }
                    // Navigator.pushReplacementNamed(this.context, '/game');
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext context) => GameWidget(
                          game: EcoinsGame(context: context),
                          overlayBuilderMap: {
                            'PauseMenu':
                                (BuildContext context, EcoinsGame game) {
                              return pause_menu(game: game);
                            }
                          }
                      ),
                    ));
                  });
                },
                // Display the correct icon depending on the state of the player.
                child: Icon(Icons.refresh_rounded),
          )),

          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "Play/Pause",
            tooltip: _controller.value.isPlaying ? "Pause" : "Play",
            onPressed: () {
              // Wrap the play or pause in a call to `setState`. This ensures the
              // correct icon is shown.
              setState(() {
                // If the video is playing, pause it.
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  // If the video is paused, play it.
                  _controller.play();
                }
              });
            },
            // Display the correct icon depending on the state of the player.
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ],
      )
    );
  }
}