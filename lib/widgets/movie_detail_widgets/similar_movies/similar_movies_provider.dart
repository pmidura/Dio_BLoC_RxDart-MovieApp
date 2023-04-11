import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repos/movie_repo.dart';
import 'similar_movies.dart';

class SimilarMoviesProvider extends StatelessWidget {
  const SimilarMoviesProvider({
    super.key,
    required this.movieRepo,
    required this.movieId,
  });

  final MovieRepo movieRepo;
  final int movieId;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.05),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(
            "SIMILAR MOVIES",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: RepositoryProvider.value(
            value: movieRepo,
            child: SimilarMovies(
              movieId: movieId,
              movieRepo: movieRepo,
            ),
          ),
        ),
      ],
    ),
  );
}
