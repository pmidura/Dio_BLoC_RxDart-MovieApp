import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/movie/movie.dart';
import '../../repos/movie_repo.dart';

part 'movie_similar_state.dart';

class MovieSimilarCubit extends Cubit<MovieSimilarState> {
  final MovieRepo repo;

  MovieSimilarCubit({required this.repo}) : super(const MovieSimilarState.loading());

  Future<void> fetchList(int id) async {
    try {
      final response = await repo.getSimilarMovies(id);
      emit(MovieSimilarState.success(response.movies));
    } on Exception {
      emit(const MovieSimilarState.failure());
    }
  }
}
