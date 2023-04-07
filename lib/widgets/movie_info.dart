import 'package:flutter/material.dart';

import '../blocs/movie_detail_bloc.dart';
import '../models/movie_detail.dart';
import '../models/movie_detail_response.dart';
import '../styles/theme.dart' as style;

class MovieInfo extends StatefulWidget {
  final int id;

  const MovieInfo({
    super.key,
    required this.id,
  });

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  void initState() {
    super.initState();
    movieDetailBloc.getMovieDetail(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    movieDetailBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<MovieDetailResponse>(
    stream: movieDetailBloc.subject.stream,
    builder: (context, AsyncSnapshot<MovieDetailResponse> snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data!.error.isNotEmpty) {
          return _buildErrorWidget(snapshot.data!.error);
        }
        return _buildInfoWidget(snapshot.data!);
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

  Widget _buildInfoWidget(MovieDetailResponse data) {
    MovieDetail detail = data.movieDetail;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "BUDGET",
                    style: TextStyle(
                      color: style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "${detail.budget}\$",
                    style: const TextStyle(
                      color: style.Colors.secondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "DURATION",
                    style: TextStyle(
                      color: style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "${detail.runtime}min",
                    style: const TextStyle(
                      color: style.Colors.secondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "RELEASE DATE",
                    style: TextStyle(
                      color: style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    detail.releaseDate,
                    style: const TextStyle(
                      color: style.Colors.secondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "GENRES",
                style: TextStyle(
                  color: style.Colors.titleColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 30.0,
                padding: const EdgeInsets.only(top: 5.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: detail.genres.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.white,
                        ),
                      ),
                      child: Text(
                        detail.genres[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 9.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
