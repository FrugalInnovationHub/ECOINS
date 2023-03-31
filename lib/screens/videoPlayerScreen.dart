import 'dart:async';

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
    _initializeVideoPlayerFuture = _controller.initialize();
        // .then((value) => { setState(() { _controller.play(); }) });

    // Use the controller to loop the video.
    // _controller.setLooping(true);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // mutes the video
    //   _controller.setVolume(0);
    //   // Plays the video once the widget is build and loaded.
    //   _controller.play();
    //   // if(_controller.value.isPlaying){
    //   //   _controller.setVolume(5);
    //   // }
    //
    //
    // });

    _controller.addListener(() {                       //custom Listner
      setState(() {
        if (!_controller.value.isPlaying && _controller.value.isInitialized &&
            (_controller.value.duration ==_controller.value.position)) { //checking the duration and position every time
          Navigator.pushReplacementNamed(context, '/main-menu');
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
            // _controller.addListener(() {
            //   if (_controller.value.isInitialized &&
            //       !_controller.value.isPlaying) {
            //     _controller.play();
            //   }
            // });
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return VideoPlayer(_controller);
            //   AspectRatio(
            //   aspectRatio: _controller.value.aspectRatio,
            //   // Use the VideoPlayer widget to display the video.
            //   child: VideoPlayer(_controller),
            // );
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
          FloatingActionButton(
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
                Navigator.pushReplacementNamed(context, '/main-menu');
              });
            },
            // Display the correct icon depending on the state of the player.
            child: Icon(Icons.refresh_rounded),
          ),
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