import 'package:flutter/material.dart';

import '../styles/theme.dart' as style;
import '../widgets/genres.dart';
import '../widgets/now_playing.dart';
import '../widgets/persons.dart';
import '../widgets/top_movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: style.Colors.mainColor,
    body: ListView(
      children: const <Widget>[
        NowPlaying(),
        Genres(),
        Persons(),
        TopMovies(),
      ],
    ),
  );
}
