import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/movie_detail/movie_detail_cubit.dart';
import '../../repos/movie_repo.dart';
import 'movie_detail_screen.dart';

class MovieProvider extends StatelessWidget {
  final MovieRepo movieRepo;
  final int movieId;

  const MovieProvider({super.key, required this.movieRepo, required this.movieId});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => MovieDetailCubit(repo: movieRepo)..fetchMovie(movieId),
    child: MovieDetailScreen(movieRepo: movieRepo, movieId: movieId),
  );
}
