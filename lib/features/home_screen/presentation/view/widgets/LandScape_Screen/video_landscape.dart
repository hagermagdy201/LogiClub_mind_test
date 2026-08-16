import 'package:flutter/material.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:video_player/video_player.dart';

class VideoLandscape extends StatefulWidget {
  const VideoLandscape({super.key});

  @override
  State<VideoLandscape> createState() => _VideoLandscapeState();
}

class _VideoLandscapeState extends State<VideoLandscape> {
  late VideoPlayerController _controller;
  bool isLooping = false;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/video/horizontal_video.mp4')
          ..initialize().then((_) {
            print(
              'Initialized:++++++++++++++++++++++++ ${_controller.value.isInitialized}',
            );
            print(
              'Error: ++++++++++++++++++++++${_controller.value.errorDescription}',
            );
            setState(() {}); // مهم جدًا عشان يظهر الفيديو
            _controller.play();
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: Center(
        child: _controller.value.isInitialized
            ? SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: color.primary,
            heroTag: "loop",
            onPressed: () {
              setState(() {
                isLooping = !isLooping;
                _controller.setLooping(isLooping);
              });
            },
            child: Icon(
              isLooping ? Icons.repeat : Icons.repeat,
              color: color.fontcolor,
            ),
          ),

          const SizedBox(height: 10),

          FloatingActionButton(
            backgroundColor: color.primary,
            heroTag: "play_pause",
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: color.fontcolor,
            ),
          ),
        ],
      ),
    );
  }
}
