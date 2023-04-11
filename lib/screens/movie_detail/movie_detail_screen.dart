import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/movie_detail/movie_detail_cubit.dart' as movie_cubit;
import '../../blocs/movie_videos/movie_videos_cubit.dart' as video_cubit;
import '../../repos/movie_repo.dart';
import '../../styles/theme.dart' as style;
import '../../widgets/additional_widgets/error.dart';
import '../../widgets/additional_widgets/loading.dart';
import '../../widgets/movie_detail_widgets/about_movie/about_info.dart';
import '../../widgets/movie_detail_widgets/about_movie/about_movie.dart';
import '../../widgets/movie_detail_widgets/casts_detail/casts_detail_provider.dart';
import '../../widgets/movie_detail_widgets/info_overview.dart';
import '../../widgets/movie_detail_widgets/similar_movies/similar_movies_provider.dart';
import '../../widgets/movie_detail_widgets/top_widget.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieRepo movieRepo;
  final int movieId;

  const MovieDetailScreen({
    super.key,
    required this.movieRepo,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    final movieState = context.watch<movie_cubit.MovieDetailCubit>().state;
    final videoState = context.watch<video_cubit.MovieVideosCubit>().state;

    switch (movieState.status) {
      case movie_cubit.ListStatus.loading:
        return loadingWidget();
      case movie_cubit.ListStatus.failure:
        return errorWidget(movieState.status.toString());
      case movie_cubit.ListStatus.success:
        return Scaffold(
          backgroundColor: style.Colors.mainColor,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              TopWidget(movieState: movieState, videoState: videoState),
              InfoOverview(state: movieState),
              const SizedBox(height: 10.0),
              CastsDetailProvider(movieRepo: movieRepo, movieId: movieId),
              const SizedBox(height: 20.0),
              const AboutMovie(),
              const SizedBox(height: 10.0),
              AboutInfo(state: movieState),
              const SizedBox(height: 20.0),
              SimilarMoviesProvider(movieRepo: movieRepo, movieId: movieId),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      default:
        return loadingWidget();
    }
  }
}
