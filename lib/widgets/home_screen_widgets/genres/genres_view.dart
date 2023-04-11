import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/genres/genres_cubit.dart';
import '../../../models/genre/genre.dart';
import '../../../repos/movie_repo.dart';
import '../../additional_widgets/error.dart';
import '../../additional_widgets/loading.dart';
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
        return loadingWidget();
      case ListStatus.failure:
        return errorWidget(state.status.toString());
      case ListStatus.success:
        if (state.genres.isEmpty) {
          return const Text("No Genre");
        } else {
          return GenresList(genres: genres, movieRepo: movieRepo);
        }
      default:
        return loadingWidget();
    }
  }
}
