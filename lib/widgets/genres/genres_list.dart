import 'package:flutter/material.dart';

import '../../models/genre/genre.dart';
import '../../repos/movie_repo.dart';
import '../../styles/theme.dart' as style;
import 'genre_movies.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;
  final MovieRepo movieRepo;

  const GenresList({
    super.key,
    required this.genres,
    required this.movieRepo,
  });

  @override
  State<GenresList> createState() => _GenresListState();
}

class _GenresListState extends State<GenresList> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.genres.length,
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 307.0,
    child: DefaultTabController(
      length: widget.genres.length,
      child: Scaffold(
        backgroundColor: style.Colors.mainColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: style.Colors.mainColor,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: style.Colors.secondColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3.0,
              unselectedLabelColor: style.Colors.titleColor,
              labelColor: Colors.white,
              isScrollable: true,
              tabs: widget.genres.map((Genre genre) => Container(
                padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                child: Text(
                  genre.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )).toList(),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: widget.genres.map((Genre genre) => GenreMovies(genreId: genre.id, movieRepo: widget.movieRepo)).toList(),
        ),
      ),
    ),
  );
}
