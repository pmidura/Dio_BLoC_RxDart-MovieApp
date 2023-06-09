import 'package:flutter/material.dart';

import '../repos/movie_repo.dart';
import '../styles/theme.dart' as style;
import '../widgets/home_screen_widgets/genres/genres.dart';
import '../widgets/home_screen_widgets/now_playing/now_playing.dart';
import '../widgets/home_screen_widgets/persons/persons.dart';
import '../widgets/home_screen_widgets/top_movies/top_movies.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.movieRepo});

  final MovieRepo movieRepo;
  
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: style.Colors.mainColor,
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
