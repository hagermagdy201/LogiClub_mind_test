import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPotrait extends StatefulWidget {
  const VideoPotrait({super.key});

  @override
  State<VideoPotrait> createState() => _VideoPotraitState();
}

class _VideoPotraitState extends State<VideoPotrait> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/vertocal_video.mp4')
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
