import 'package:equatable/equatable.dart';

import '../genre/genre.dart';

class MovieDetail extends Equatable {
  final int id;
  final num popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final double rating;
  final String releaseDate;
  final List<Genre> genres;
  final int budget;
  final int revenue;
  final String status;
  final int runtime;

  const MovieDetail({
    required this.id,
    required this.popularity,
    required this.title,
    required this.backPoster,
    required this.poster,
    required this.overview,
    required this.rating,
    required this.releaseDate,
    required this.genres,
    required this.budget,
    required this.revenue,
    required this.status,
    required this.runtime,
  });

  MovieDetail.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? 0,
    popularity = json["popularity"] ?? 0,
    title = json["title"] ?? "",
    backPoster = json["backdrop_path"] ?? "",
    poster = json["poster_path"] ?? "",
    overview = json["overview"] ?? "",
    rating = json["vote_average"] ?? 0.0,
    releaseDate = json["release_date"] ?? "",
    genres = (json["genres"] as List).map((e) => Genre.fromJson(e)).toList(),
    budget = json["budget"] ?? 0,
    revenue = json["revenue"] ?? 0,
    status = json["status"] ?? "",
    runtime = json["runtime"] ?? "";

  @override
  List<Object> get props => [
    id,
    popularity,
    title,
    backPoster,
    poster,
    overview,
    rating,
    releaseDate,
    genres,
    budget,
    revenue,
    status,
    runtime,
  ];

  static const empty = MovieDetail(
    id: 0,
    popularity: 0,
    title: "",
    backPoster: "",
    poster: "",
    overview: "",
    rating: 0.0,
    releaseDate: "",
    genres: [],
    budget: 0,
    revenue: 0,
    status: "",
    runtime: 0,
  );
}
