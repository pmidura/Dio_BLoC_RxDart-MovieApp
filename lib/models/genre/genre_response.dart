import 'genre.dart';

class GenreResponse {
  final List<Genre> genres;
  final String error;

  GenreResponse({
    required this.genres,
    required this.error,
  });
  
  GenreResponse.fromJson(Map<String, dynamic> json) :
    genres = (json["genres"] as List).map((e) => Genre.fromJson(e)).toList(),
    error = "";

  GenreResponse.withError(String errorVal) :
    genres = [],
    error = errorVal;
}
