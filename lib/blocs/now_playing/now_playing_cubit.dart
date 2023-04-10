import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/movie/movie.dart';
import '../../repos/movie_repo.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final MovieRepo repo;

  NowPlayingCubit({required this.repo}) : super(const NowPlayingState.loading());

  Future<void> getNowPlaying() async {
    try {
      final response = await repo.getPlayingMovies();
      emit(NowPlayingState.success(response.movies));
    } on Exception {
      emit(const NowPlayingState.failure());
    }
  }
}
