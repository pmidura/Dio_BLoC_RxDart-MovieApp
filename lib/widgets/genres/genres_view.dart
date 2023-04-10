import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/genres/genres_cubit.dart';
import '../../models/genre/genre.dart';
import '../../repos/movie_repo.dart';
import 'genres_list.dart';

class GenresView extends StatelessWidget {
  const GenresView({super.key, required this.movieRepo});

  final MovieRepo movieRepo;
  
  @override
  Widget build(BuildContext context) {
    final state = context.watch<GenresCubit>().state;
    final List<Genre> genres = state.genres;

    switch (state.status) {
      case ListStatus.loading:
        return _buildLoadingWidget();
      case ListStatus.failure:
        return _buildErrorWidget(state.status.toString());
      case ListStatus.success:
        if (state.genres.isEmpty) {
          return const Text("No Genre");
        } else {
          return GenresList(genres: genres, movieRepo: movieRepo);
        }
      default:
        return _buildLoadingWidget();
    }
  }
  
  Widget _buildLoadingWidget() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
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
}
