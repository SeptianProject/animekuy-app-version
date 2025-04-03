import 'package:flutter/material.dart';

class AnimeVideoPlayer extends StatelessWidget {
  final String videoUrl;

  const AnimeVideoPlayer({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    // This is just a placeholder for a real video player
    // You would implement with a package like video_player or chewie
    return Container(
      height: 200,
      color: Colors.black,
      child: const Center(
        child: Icon(Icons.play_circle_outline, color: Colors.white, size: 50),
      ),
    );
  }
}
