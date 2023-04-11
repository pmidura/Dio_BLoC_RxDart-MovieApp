import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/movie_detail/movie_detail_cubit.dart';
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
    final state = context.watch<MovieDetailCubit>().state;

    switch (state.status) {
      case ListStatus.loading:
        return loadingWidget();
      case ListStatus.failure:
        return errorWidget(state.status.toString());
      case ListStatus.success:
        return Scaffold(
          backgroundColor: style.Colors.mainColor,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              TopWidget(state: state),
              InfoOverview(state: state),
              const SizedBox(height: 10.0),
              CastsDetailProvider(movieRepo: movieRepo, movieId: movieId),
              const SizedBox(height: 20.0),
              const AboutMovie(),
              const SizedBox(height: 10.0),
              AboutInfo(state: state),
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

  // Widget _buildVideoWidget(VideoResponse data) {
  //   List<Video> videos = data.videos;
    
  //   return FloatingActionButton(
  //     onPressed: () => Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => VideoPlayer(
  //           controller: YoutubePlayerController(
  //             initialVideoId: videos[0].key,
  //             flags: const YoutubePlayerFlags(
  //               autoPlay: true,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //     backgroundColor: style.Colors.secondColor,
  //     child: const Icon(Icons.play_arrow),
  //   );
  // }
}
