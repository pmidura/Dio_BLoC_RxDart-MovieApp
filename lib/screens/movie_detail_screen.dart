import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sliver_fab/sliver_fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../blocs/movie_videos_bloc.dart';
import '../models/movie.dart';
import '../models/video.dart';
import '../models/video_response.dart';
import '../screens/video_player.dart';
import '../styles/theme.dart' as style;
import '../widgets/casts.dart';
import '../widgets/movie_info.dart';
import '../widgets/similar_movies.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    movieVideosBloc.getMovieVideos(widget.movie.id);
  }

  @override
  void dispose() {
    super.dispose();
    movieVideosBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: style.Colors.mainColor,
    body: Builder(
      builder: (context) => SliverFab(
        floatingPosition: const FloatingPosition(right: 20.0),
        floatingWidget: StreamBuilder<VideoResponse>(
          stream: movieVideosBloc.subject.stream,
          builder: (context, AsyncSnapshot<VideoResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error.isNotEmpty) {
                return _buildErrorWidget(snapshot.data!.error);
              }
              return _buildVideoWidget(snapshot.data!);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error.toString());
            } else {
              return _buildLoadingWidget();
            }
          },
        ),
        expandedHeight: 200.0,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: style.Colors.mainColor,
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.movie.title.length > 40
                ? "${widget.movie.title.substring(0, 37)}..."
                : widget.movie.title,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: NetworkImage("https://image.tmdb.org/t/p/original/${widget.movie.backPoster}"),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.0),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.movie.rating.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      RatingBar.builder(
                        itemSize: 10.0,
                        initialRating: widget.movie.rating / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          EvaIcons.star,
                          color: style.Colors.secondColor,
                        ),
                        onRatingUpdate: (rating) => debugPrint(rating.toString()),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "OVERVIEW",
                    style: TextStyle(
                      color: style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.movie.overview,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                MovieInfo(id: widget.movie.id),
                Casts(id: widget.movie.id),
                SimilarMovies(id: widget.movie.id),
              ]),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildLoadingWidget() => Container();

  Widget _buildErrorWidget(String error) => Center(
    child: Column(
      children: <Widget>[
        Text(
          error,
        ),
      ],
    ),
  );

  Widget _buildVideoWidget(VideoResponse data) {
    List<Video> videos = data.videos;
    
    return FloatingActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayer(
            controller: YoutubePlayerController(
              initialVideoId: videos[0].key,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: style.Colors.secondColor,
      child: const Icon(Icons.play_arrow),
    );
  }
}
