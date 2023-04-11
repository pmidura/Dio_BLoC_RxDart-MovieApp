import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../blocs/movie_videos/movie_videos_cubit.dart';
import '../../repos/movie_repo.dart';
import 'video_player_view.dart';

class VideoPlayer extends StatelessWidget {
  final YoutubePlayerController controller;
  final int movieId;

  const VideoPlayer({
    super.key,
    required this.controller,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => MovieVideosCubit(repo: context.read<MovieRepo>())..getMovieVideos(movieId),
    child: VideoPlayerView(
      controller: controller,
    ),
  );
}
