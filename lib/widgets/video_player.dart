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
    // Initialize the video player controller with a video file or URL
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    // Initialize the controller and store the Future for later use
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

  double screenWidth = MediaQuery.of(context).size.width;
  double maxWidth = screenWidth < 600
      ? screenWidth // phones
      : screenWidth < 1200
          ? screenWidth * 0.5 // tablets/small desktops
          : 700.0; // max cap on large desktops

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: maxWidth,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the video is initialized, display the video player
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                );
              } else {
                // If the video is still loading, show a loading spinner
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        SizedBox(height: 20),
        FloatingActionButton(onPressed: () {
          setState(() {
            // Toggle play/pause when the button is pressed
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        )),
      ],
    );
  }
}