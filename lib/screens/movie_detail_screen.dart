import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/movie/movie.dart';
import '../repos/movie_repo.dart';
import '../styles/theme.dart' as style;

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  final MovieRepo movieRepo;

  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.movieRepo,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
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
                      image: "https://image.tmdb.org/t/p/original/${movie.backPoster}",
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
                                  image: "https://image.tmdb.org/t/p/w200/${movie.poster}",
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
                              movie.title,
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
                                  "Release date: getReleaseDate!",
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
                  const Icon(
                    EvaIcons.clockOutline,
                    size: 15.0,
                  ),
                  const SizedBox(width: 5.0),
                  const Text(
                    "MOVIE RUNTIME!",
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      height: 40.0,
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // itemCount: movie.genres.length,
                        itemCount: 10,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                color: Colors.white.withOpacity(0.1),
                              ),
                              child: const Text(
                                // movie.genres[index].name,
                                'GENRES NAME',
                                maxLines: 2,
                                style: TextStyle(
                                  height: 1.4,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.0,
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
                movie.overview,
                style: const TextStyle(
                  height: 1.5,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
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
              // RepositoryProvider.value(
              //   value: movieRepo,
              //   child: Casts(),
              // ),
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
                  const Text(
                    "movie.status",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
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
                  const Text(
                    "\$ movie.budget",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
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
                  const Text(
                    "\$ movie.revenue",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
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
              const Padding(
                padding: EdgeInsets.only(left: 2.0),
                // child: RepositoryProvider.value(
                //   value: movieRepo,
                //   child: SimilarMovies(),
                // ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    ),
  );
}

    //   builder: (context) => SliverFab(
    //     floatingPosition: const FloatingPosition(right: 20.0),


    //     // floatingWidget: StreamBuilder<VideoResponse>(
    //     //   stream: movieVideosBloc.subject.stream,
    //     //   builder: (context, AsyncSnapshot<VideoResponse> snapshot) {
    //     //     if (snapshot.hasData) {
    //     //       if (snapshot.data!.error.isNotEmpty) {
    //     //         return _buildErrorWidget(snapshot.data!.error);
    //     //       }
    //     //       return _buildVideoWidget(snapshot.data!);
    //     //     } else if (snapshot.hasError) {
    //     //       return _buildErrorWidget(snapshot.error.toString());
    //     //     } else {
    //     //       return _buildLoadingWidget();
    //     //     }
    //     //   },
    //     // ),


    //     expandedHeight: 200.0,
    //     slivers: [
    //       SliverAppBar(
    //         backgroundColor: style.Colors.mainColor,
    //         expandedHeight: 200.0,
    //         pinned: true,
    //         flexibleSpace: FlexibleSpaceBar(
    //           title: Text(
    //             movie.title.length > 40
    //             ? "${movie.title.substring(0, 37)}..."
    //             : movie.title,
    //             style: const TextStyle(
    //               fontSize: 12.0,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           background: Stack(
    //             children: [
    //               Container(
    //                 decoration: BoxDecoration(
    //                   shape: BoxShape.rectangle,
    //                   image: DecorationImage(
    //                     image: NetworkImage("https://image.tmdb.org/t/p/original/${movie.backPoster}"),
    //                   ),
    //                 ),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     color: Colors.black.withOpacity(0.0),
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 decoration: BoxDecoration(
    //                   gradient: LinearGradient(
    //                     begin: Alignment.bottomCenter,
    //                     end: Alignment.topCenter,
    //                     colors: [
    //                       Colors.black.withOpacity(0.9),
    //                       Colors.black.withOpacity(0.0),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       SliverPadding(
    //         padding: const EdgeInsets.all(0.0),
    //         sliver: SliverList(
    //           delegate: SliverChildListDelegate([
    //             Padding(
    //               padding: const EdgeInsets.only(left: 10.0, top: 20.0),
    //               child: Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     movie.rating.toString(),
    //                     style: const TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 14.0,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   const SizedBox(width: 5.0),
    //                   RatingBar.builder(
    //                     itemSize: 10.0,
    //                     initialRating: movie.rating / 2,
    //                     minRating: 1,
    //                     direction: Axis.horizontal,
    //                     allowHalfRating: true,
    //                     itemCount: 5,
    //                     itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
    //                     itemBuilder: (context, _) => const Icon(
    //                       EvaIcons.star,
    //                       color: style.Colors.secondColor,
    //                     ),
    //                     onRatingUpdate: (rating) => debugPrint(rating.toString()),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const Padding(
    //               padding: EdgeInsets.only(left: 10.0, top: 20.0),
    //               child: Text(
    //                 "OVERVIEW",
    //                 style: TextStyle(
    //                   color: style.Colors.titleColor,
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: 12.0,
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 5.0),
    //             Padding(
    //               padding: const EdgeInsets.all(10.0),
    //               child: Text(
    //                 movie.overview,
    //                 style: const TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 12.0,
    //                   height: 1.5,
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 10.0),
    //             // MovieInfo(id: widget.movie.id),
    //             // Casts(id: widget.movie.id),
    //             // SimilarMovies(id: widget.movie.id),
    //           ]),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),


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

