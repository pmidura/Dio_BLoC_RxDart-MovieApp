import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/casts/casts_cubit.dart';
import '../../../repos/movie_repo.dart';
import 'casts_detail_view.dart';

class CastsDetail extends StatelessWidget {
  final int movieId;
  final MovieRepo movieRepo;

  const CastsDetail({
    super.key,
    required this.movieId,
    required this.movieRepo,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => CastsCubit(
      repo: context.read<MovieRepo>(),
    )..fetchCasts(movieId),
    child: CastsDetailView(
      movieId: movieId,
      movieRepo: movieRepo,
    ),
  );
}
