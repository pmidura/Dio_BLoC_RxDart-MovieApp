import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final YoutubePlayerController controller;

  const VideoPlayer({
    super.key,
    required this.controller,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: Stack(
      children: <Widget>[
        Center(
          child: YoutubePlayer(controller: widget.controller),
        ),
        Positioned(
          top: 40.0,
          right: 20.0,
          child: IconButton(
            icon: const Icon(EvaIcons.closeCircle),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    ),
  );
}
