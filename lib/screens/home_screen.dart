import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
    appBar: AppBar(
      backgroundColor: style.Colors.mainColor,
      centerTitle: true,
      leading: const Icon(
        EvaIcons.menu2Outline,
        color: Colors.white,
      ),
      title: const Text("Movie App"),
      actions: const <Widget>[
        IconButton(
          onPressed: null,
          icon: Icon(
            EvaIcons.searchOutline,
            color: Colors.white,
          ),
        ),
      ],
    ),
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
