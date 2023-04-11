import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../blocs/movie_detail/movie_detail_cubit.dart';

class InfoOverview extends StatelessWidget {
  const InfoOverview({
    super.key,
    required this.state,
  });

  final MovieDetailState state;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              EvaIcons.clockOutline,
              size: 15.0,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(width: 5.0),
            Text(
              "${state.movie.runtime} min",
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                height: 40.0,
                padding: const EdgeInsets.only(right: 10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.movie.genres.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Text(
                          state.movie.genres[index].name,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Text(
          "OVERVIEW",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          state.movie.overview,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            height: 1.5,
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
