import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/movie/movie.dart';
import '../../repos/movie_repo.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepo repo;

  MoviesCubit({required this.repo}) : super(const MoviesState.loading());

  Future<void> getMovies() async {
    try {
      final response = await repo.getMovies();
      emit(MoviesState.success(response.movies));
    } on Exception {
      emit(const MoviesState.failure());
    }
  }
}
