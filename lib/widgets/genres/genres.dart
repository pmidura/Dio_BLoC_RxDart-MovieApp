import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/genres/genres_cubit.dart';
import '../../repos/movie_repo.dart';
import 'genres_view.dart';

class Genres extends StatelessWidget{
  const Genres({super.key, required this.movieRepo});

  final MovieRepo movieRepo;

  @override
  Widget build(BuildContext context) => RepositoryProvider.value(
    value: movieRepo,
    child: BlocProvider(
      create: (_) => GenresCubit(repo: movieRepo)..getGenres(),
      child: GenresView(movieRepo: movieRepo),
    ),
  );
}
