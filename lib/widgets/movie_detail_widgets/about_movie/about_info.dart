import 'package:flutter/material.dart';

import '../../../blocs/movie_detail/movie_detail_cubit.dart';

class AboutInfo extends StatelessWidget {
  const AboutInfo({
    super.key,
    required this.state,
  });

  final MovieDetailState state;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Status:",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            Text(
              state.movie.status,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Budget:",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            Text(
              "\$ ${state.movie.budget}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Revenue:",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            Text(
              "\$ ${state.movie.revenue}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
