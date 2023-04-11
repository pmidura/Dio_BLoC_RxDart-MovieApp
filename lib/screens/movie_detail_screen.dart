import 'package:dio_bloc_rxdart_movie_app/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../repos/movie_repo.dart';
import '../styles/theme.dart' as style;
import '../widgets/movie_detail_widgets/casts.dart';
import '../widgets/movie_detail_widgets/similar_movies.dart';

class MovieProvider extends StatelessWidget {
  final MovieRepo movieRepo;
  final int movieId;

  const MovieProvider({super.key, required this.movieRepo, required this.movieId});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => MovieDetailCubit(repo: movieRepo)..fetchMovie(movieId),
    child: MovieDetailScreen(movieRepo: movieRepo, movieId: movieId),
  );
}

class MovieDetailScreen extends StatelessWidget {
  final MovieRepo movieRepo;
  final int movieId;

  const MovieDetailScreen({
    super.key,
    required this.movieRepo,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MovieDetailCubit>().state;

    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text("Oops something went wrong!", style: TextStyle(color: Colors.white)));
      case ListStatus.success:
        return Scaffold(
          backgroundColor: style.Colors.mainColor,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
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
                            image: "https://image.tmdb.org/t/p/original/${state.movie.backPoster}",
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
                                        image: "https://image.tmdb.org/t/p/w200/${state.movie.poster}",
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
                                    state.movie.title,
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
                                        "Release date: ${state.movie.releaseDate}",
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          EvaIcons.clockOutline,
                          size: 15.0,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          "${state.movie.runtime} min",
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Container(
                            height: 40.0,
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.movie.genres.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                    child: Text(
                                      state.movie.genres[index].name,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "OVERVIEW",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      state.movie.overview,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        height: 1.5,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CASTS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RepositoryProvider.value(
                      value: movieRepo,
                      child: Casts(
                        movieId: movieId,
                        movieRepo: movieRepo,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "ABOUT MOVIE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status:",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          state.movie.status,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Budget:",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          "\$ ${state.movie.budget}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Revenue:",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          "\$ ${state.movie.revenue}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        "SIMILAR MOVIES",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: RepositoryProvider.value(
                        value: movieRepo,
                        child: SimilarMovies(
                          movieId: movieId,
                          movieRepo: movieRepo,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}

  // Widget _buildLoadingWidget() => Container();

  // Widget _buildErrorWidget(String error) => Center(
  //   child: Column(
  //     children: [
  //       Text(
  //         error,
  //       ),
  //     ],
  //   ),
  // );

  // Widget _buildVideoWidget(VideoResponse data) {
  //   List<Video> videos = data.videos;
    
  //   return FloatingActionButton(
  //     onPressed: () => Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => VideoPlayer(
  //           controller: YoutubePlayerController(
  //             initialVideoId: videos[0].key,
  //             flags: const YoutubePlayerFlags(
  //               autoPlay: true,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //     backgroundColor: style.Colors.secondColor,
  //     child: const Icon(Icons.play_arrow),
  //   );
  // }

