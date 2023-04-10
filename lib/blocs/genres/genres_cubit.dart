import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/genre/genre.dart';
import '../../repos/movie_repo.dart';

part 'genres_state.dart';

class GenresCubit extends Cubit<GenresState> {
  final MovieRepo repo;

  GenresCubit({required this.repo}) : super(const GenresState.loading());

  Future<void> getGenres() async {
    try {
      final response = await repo.getGenres();
      emit(GenresState.success(response.genres));
    } on Exception {
      emit(const GenresState.failure());
    }
  }
}
