import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../blocs/movie_detail/movie_detail_cubit.dart';
import '../../blocs/movie_videos/movie_videos_cubit.dart';
import '../../screens/video_player/video_player.dart';
import '../../styles/theme.dart' as style;

class TopWidget extends StatelessWidget {
  const TopWidget({
    super.key,
    required this.movieState,
    required this.videoState,
  });

  final MovieDetailState movieState;
  final MovieVideosState videoState;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Stack(
      children: [
        Stack(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.white54,
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 3 / 2,
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                image: "https://image.tmdb.org/t/p/original/${movieState.movie.backPoster}",
              ),
            ),
          ],
        ),
        AspectRatio(
          aspectRatio: 3 / 2,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(1.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 1],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 10.0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.white10,
                      highlightColor: Colors.white30,
                      enabled: true,
                      child: SizedBox(
                        height: 120.0,
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.black12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      height: 120.0,
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: "https://image.tmdb.org/t/p/w200/${movieState.movie.poster}",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        movieState.movie.title,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Release date: ${movieState.movie.releaseDate}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 5.0,
          top: 20.0,
          child: SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                EvaIcons.arrowIosBack,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                child: IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: videoState.videos[0].key,
                          flags: const YoutubePlayerFlags(
                            autoPlay: true,
                          ),
                        ),
                        movieId: movieState.movie.id,
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    color: style.Colors.secondColor,
                    size: 50.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
