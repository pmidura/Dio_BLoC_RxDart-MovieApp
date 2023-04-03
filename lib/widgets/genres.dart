import 'package:flutter/material.dart';

import '../blocs/genres_bloc.dart';
import '../models/genre.dart';
import '../models/genre_response.dart';
import '../widgets/genres_list.dart';

class Genres extends StatefulWidget {
  const Genres({super.key});

  @override
  State<Genres> createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  void initState() {
    super.initState();
    genresBloc.getGenres();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
    stream: genresBloc.subject.stream,
    builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data!.error.isNotEmpty) {
          return _buildErrorWidget(snapshot.data!.error);
        }
        return _buildGenresWidget(snapshot.data!);
      } else if (snapshot.hasError) {
        return _buildErrorWidget(snapshot.error.toString());
      } else {
        return _buildLoadingWidget();
      }
    },
  );

  Widget _buildLoadingWidget() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(),
        ),
      ],
    ),
  );

  Widget _buildErrorWidget(String error) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ),
  );

  Widget _buildGenresWidget(GenreResponse data) {
    List<Genre> genres = data.genres;

    if (genres.isEmpty) {
      return const Text("No Genre");
    } else {
      return GenresList(genres: genres);
    }
  }
}
