import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/movies/movies_cubit.dart';
import '../../../repos/movie_repo.dart';
import '../../../styles/theme.dart' as style;
import 'top_movies_view.dart';

class TopMovies extends StatelessWidget {
  const TopMovies({super.key, required this.movieRepo});
  
  final MovieRepo movieRepo;
  
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        child: Text(
          "TOP RATED MOVIES",
          style: TextStyle(
            color: style.Colors.titleColor,
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
          ),
        ),
      ),
      const SizedBox(height: 5.0),
      RepositoryProvider.value(
        value: movieRepo,
        child: BlocProvider(
          create: (_) => MoviesCubit(repo: movieRepo)..getMovies(),
          child: TopMoviesView(movieRepo: movieRepo),
        ),
      ),
    ],
  );
}
