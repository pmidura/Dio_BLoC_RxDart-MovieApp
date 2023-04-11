import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repos/movie_repo.dart';
import 'casts_detail.dart';

class CastsDetailProvider extends StatelessWidget {
  const CastsDetailProvider({
    super.key,
    required this.movieRepo,
    required this.movieId,
  });

  final MovieRepo movieRepo;
  final int movieId;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.05),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CASTS",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 10.0),
        RepositoryProvider.value(
          value: movieRepo,
          child: CastsDetail(
            movieId: movieId,
            movieRepo: movieRepo,
          ),
        ),
      ],
    ),
  );
}
