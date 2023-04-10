import 'movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final String error;

  MovieResponse({
    required this.movies,
    required this.error,
  });
  
  MovieResponse.fromJson(Map<String, dynamic> json) :
    movies = (json["results"] as List).map((e) => Movie.fromJson(e)).toList(),
    error = "";

  MovieResponse.withError(String errorVal) :
    movies = [],
    error = errorVal;
}
