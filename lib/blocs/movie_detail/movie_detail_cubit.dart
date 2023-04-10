import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/movie_detail/movie_detail.dart';
import '../../repos/movie_repo.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieRepo repo;
  
  MovieDetailCubit({required this.repo}) : super(const MovieDetailState.loading());

  Future<void> fetchMovie(int id) async {
    try {
      final response = await repo.getMovieDetail(id);
      emit(MovieDetailState.success(response.movieDetail));
    } on Exception {
      emit(const MovieDetailState.failure());
    }
  }
}
