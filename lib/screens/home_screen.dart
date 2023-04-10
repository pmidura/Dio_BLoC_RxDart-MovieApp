import 'package:flutter/material.dart';

import '../repos/movie_repo.dart';
import '../styles/theme.dart' as style;
import '../widgets/genres/genres.dart';
import '../widgets/now_playing/now_playing.dart';
import '../widgets/persons/persons.dart';
import '../widgets/top_movies/top_movies.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.movieRepo});

  final MovieRepo movieRepo;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: style.Colors.mainColor,
    appBar: AppBar(
      title: const Text("Movie App"),
      centerTitle: true,
      backgroundColor: style.Colors.mainColor,
    ),
    body: ListView(
      children: [
        NowPlaying(movieRepo: movieRepo),
        Genres(movieRepo: movieRepo),
        Persons(movieRepo: movieRepo),
        TopMovies(movieRepo: movieRepo,),
      ],
    ),
  );
}
