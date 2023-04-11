import 'package:dio_bloc_rxdart_movie_app/blocs/movie_videos/movie_videos_cubit.dart';
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
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<MovieDetailCubit>(
        create: (_) => MovieDetailCubit(repo: movieRepo)..fetchMovie(movieId),
      ),
      BlocProvider<MovieVideosCubit>(
        create: (_) => MovieVideosCubit(repo: movieRepo)..getMovieVideos(movieId),
      ),
    ],
    child: MovieDetailScreen(
      movieRepo: movieRepo,
      movieId: movieId,
    ),
  );
}
