import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final num popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final double rating;
  
  const Movie({
    required this.id,
    required this.popularity,
    required this.title,
    required this.backPoster,
    required this.poster,
    required this.overview,
    required this.rating,
  });

  Movie.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? 0,
    popularity = json["popularity"] ?? 0,
    title = json["title"] ?? "",
    backPoster = json["backdrop_path"] ?? "",
    poster = json["poster_path"] ?? "",
    overview = json["overview"] ?? "",
    rating = json["vote_average"].toDouble() ?? 0.0;

  @override
  List<Object?> get props => [
    id,
    popularity,
    title,
    backPoster,
    poster,
    overview,
    rating,
  ];

  static const empty = Movie(
    id: 0,
    popularity: 0,
    title: "",
    backPoster: "",
    poster: "",
    overview: "",
    rating: 0.0,
  );
}
