import 'genre.dart';

class MovieDetail {
  final int id;
  final bool adult;
  final int budget;
  final List<Genre> genres;
  final String releaseDate;
  final int runtime;

  MovieDetail({
    required this.id,
    required this.adult,
    required this.budget,
    required this.genres,
    required this.releaseDate,
    required this.runtime,
  });

  MovieDetail.fromJson(Map<String, dynamic> json) :
    id = json["id"],
    adult = json["adult"],
    budget = json["budget"],
    genres = (json["genres"] as List).map((e) => Genre.fromJson(e)).toList(),
    releaseDate = json["release_date"],
    runtime = json["runtime"];
}
