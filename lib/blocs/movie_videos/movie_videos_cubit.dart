import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/video/video.dart';
import '../../repos/movie_repo.dart';

part 'movie_videos_state.dart';

class MovieVideosCubit extends Cubit<MovieVideosState> {
  final MovieRepo repo;

  MovieVideosCubit({required this.repo}) : super(const MovieVideosState.loading());

  Future<void> getMovieVideos(int id) async {
    try {
      final response = await repo.getMovieVideos(id);
    emit(MovieVideosState.success(response.videos));
    } on Exception {
      emit(const MovieVideosState.failure());
    }
  }
}
