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
      'https://github.com/brysonreese/FridayCountdown/raw/refs/heads/dev/assets/videos/friday.mp4',
      ),
    );

    // Initialize the controller and store the Future for later use
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized
      _controller.setVolume(0.0);
      _controller.setLooping(true);
      _controller.play();
      setState(() {});
    });
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
  double maxWidth = screenWidth < 500
      ? screenWidth // phones
      : screenWidth < 1000
          ? screenWidth * 0.5 // tablets/small desktops
          : 600.0; // max cap on large desktops

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
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle play/pause when the video is tapped
                          _controller.value.volume == 0.0 ? _controller.setVolume(1.0) : _controller.setVolume(0.0);
                        });
                      },
                    )
                  ,)]
                  );
              } else {
                // If the video is still loading, show a loading spinner
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}