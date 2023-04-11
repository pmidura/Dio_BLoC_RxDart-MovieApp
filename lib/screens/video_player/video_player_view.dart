import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerView extends StatelessWidget {
  final YoutubePlayerController controller;

  const VideoPlayerView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: Stack(
      children: [
        Center(
          child: YoutubePlayer(
            controller: controller,
          ),
        ),
        Positioned(
          top: 40.0,
          right: 20.0,
          child: IconButton(
            icon: const Icon(
              EvaIcons.closeCircle,
            ),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    ),
  );
}
