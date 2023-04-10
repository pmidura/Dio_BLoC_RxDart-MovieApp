import 'package:equatable/equatable.dart';

import '../genre/genre.dart';

class MovieDetail extends Equatable {
  final int id;
  final int budget;
  final List<Genre> genres;
  final String releaseDate;
  final int runtime;

  const MovieDetail({
    required this.id,
    required this.budget,
    required this.genres,
    required this.releaseDate,
    required this.runtime,
  });

  MovieDetail.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? 0,
    budget = json["budget"] ?? 0,
    genres = (json["genres"] as List).map((e) => Genre.fromJson(e)).toList(),
    releaseDate = json["release_date"] ?? "",
    runtime = json["runtime"] ?? "";

  @override
  List<Object> get props => [id, budget, genres, releaseDate, runtime];

  static const empty = MovieDetail(id: 0, budget: 0, genres: [], releaseDate: "", runtime: 0);
}
