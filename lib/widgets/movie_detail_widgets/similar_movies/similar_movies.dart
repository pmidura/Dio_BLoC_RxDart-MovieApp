import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/movie_similar/movie_similar_cubit.dart';
import '../../../repos/movie_repo.dart';
import 'similar_movies_view.dart';

class SimilarMovies extends StatelessWidget {
  final int movieId;
  final MovieRepo movieRepo;

  const SimilarMovies({
    super.key,
    required this.movieId,
    required this.movieRepo,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => MovieSimilarCubit(
      repo: context.read<MovieRepo>(),
    )..fetchList(movieId),
    child: SimilarMoviesView(
      movieId: movieId,
      movieRepo: movieRepo,
    ),
  );
}
