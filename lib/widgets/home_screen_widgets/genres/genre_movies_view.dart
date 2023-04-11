import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../blocs/movies_by_genre/movies_by_genre_cubit.dart';
import '../../../models/movie/movie.dart';
import '../../../repos/movie_repo.dart';
import '../../../screens/movie_detail/movie_provider.dart';
import '../../../styles/theme.dart' as style;
import '../../additional_widgets/error.dart';
import '../../additional_widgets/loading.dart';

class GenreMoviesView extends StatelessWidget {
  const GenreMoviesView({super.key, required this.movieRepo});

  final MovieRepo movieRepo;
  
  @override
  Widget build(BuildContext context) {
    final state = context.watch<MoviesByGenreCubit>().state;
    final List<Movie> movies = state.movies;

    switch (state.status) {
      case ListStatus.loading:
        return loadingWidget();
      case ListStatus.failure:
        return errorWidget(state.status.toString());
      case ListStatus.success:
        if (movies.isEmpty) {
          return const Text("No Movies");
        } else {
          return Container(
            height: 270.0,
            padding: const EdgeInsets.only(left: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder:(context, index) => Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MovieProvider(
                        movieRepo: movieRepo,
                        movieId: movies[index].id,
                      ),
                    ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      movies[index].poster.isEmpty ?
                      Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: const BoxDecoration(
                          color: style.Colors.secondColor,
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              EvaIcons.filmOutline,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ],
                        ),
                      ) :
                      Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: NetworkImage("https://image.tmdb.org/t/p/w200/${movies[index].poster}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        width: 100.0,
                        child: Text(
                          movies[index].title.length > 18
                          ? "${movies[index].title.substring(0, 15)}..."
                          : movies[index].title,
                          maxLines: 2,
                          style: const TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          Text(
                            movies[index].rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          RatingBar.builder(
                            itemSize: 8.0,
                            initialRating: movies[index].rating / 2,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              EvaIcons.star,
                              color: style.Colors.secondColor,
                            ),
                            onRatingUpdate: (rating) => debugPrint(rating.toString()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      default:
        return loadingWidget();
    }
  }
}
