import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../blocs/movie_similar_bloc.dart';
import '../models/movie.dart';
import '../models/movie_response.dart';
import '../styles/theme.dart' as style;

class SimilarMovies extends StatefulWidget {
  final int id;

  const SimilarMovies({
    super.key,
    required this.id,
  });

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  @override
  void initState() {
    super.initState();
    similarMoviesBloc.getSimilarMovies(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    similarMoviesBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Padding(
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        child: Text(
          "SIMILAR MOVIES",
          style: TextStyle(
            color: style.Colors.titleColor,
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
          ),
        ),
      ),
      const SizedBox(height: 5.0),
      StreamBuilder<MovieResponse>(
        stream: similarMoviesBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.error.isNotEmpty) {
              return _buildErrorWidget(snapshot.data!.error);
            }
            return _buildMoviesWidget(snapshot.data!);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error.toString());
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    ],
  );

  Widget _buildLoadingWidget() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(),
        ),
      ],
    ),
  );

  Widget _buildErrorWidget(String error) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ),
  );

  Widget _buildMoviesWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    
    if (movies.isEmpty) {
      return const Text("No Movies");
    } else {
      return Container(
        height: 270.0,
        padding: const EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder:(context, index) => Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
            child: Column(
              children: <Widget>[
                movies[index].poster.isEmpty ?
                Container(
                  width: 120.0,
                  height: 180.0,
                  decoration: const BoxDecoration(
                    color: style.Colors.secondColor,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    children: const <Widget>[
                      Icon(
                        EvaIcons.filmOutline,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ],
                  ),
                ) :
                Container(
                  width: 120.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: NetworkImage("https://image.tmdb.org/t/p/w200/${movies[index].poster}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: 100.0,
                  child: Text(
                    movies[index].title,
                    maxLines: 2,
                    style: const TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    Text(
                      movies[index].rating.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    RatingBar.builder(
                      itemSize: 8.0,
                      initialRating: movies[index].rating / 2,
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
              ],
            ),
          ),
        ),
      );
    }
  }
}
