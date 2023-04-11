import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/now_playing/now_playing_cubit.dart';
import '../../../repos/movie_repo.dart';
import 'now_playing_view.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key, required this.movieRepo});
  
  final MovieRepo movieRepo;

  @override
  Widget build(BuildContext context) => RepositoryProvider.value(
    value: movieRepo,
    child: BlocProvider(
      create: (_) => NowPlayingCubit(repo: movieRepo)..getNowPlaying(),
      child: NowPlayingView(movieRepo: movieRepo),
    ),
  );
}
