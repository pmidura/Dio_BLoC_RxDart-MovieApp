import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/movie/movie.dart';
import '../../repos/movie_repo.dart';

part 'movies_by_genre_state.dart';

class MoviesByGenreCubit extends Cubit<MoviesByGenreState> {
  final MovieRepo repo;

  MoviesByGenreCubit({required this.repo}) : super(const MoviesByGenreState.loading());

  Future<void> getMoviesByGenre(int id) async {
    try {
      final response = await repo.getMovieByGenre(id);
      emit(MoviesByGenreState.success(response.movies));
    } on Exception {
      emit(const MoviesByGenreState.failure());
    }
  }
}
