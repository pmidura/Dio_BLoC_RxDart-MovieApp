import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/movies_by_genre/movies_by_genre_cubit.dart';
import '../../../repos/movie_repo.dart';
import 'genre_movies_view.dart';

class GenreMovies extends StatelessWidget {
  final int genreId;
  final MovieRepo movieRepo;

  const GenreMovies({
    super.key,
    required this.genreId,
    required this.movieRepo,
  });

  @override
  Widget build(BuildContext context) => RepositoryProvider.value(
    value: movieRepo,
    child: BlocProvider(
      create: (_) => MoviesByGenreCubit(repo: movieRepo)..getMoviesByGenre(genreId),
      child: GenreMoviesView(movieRepo: movieRepo),
    ),
  );
}
