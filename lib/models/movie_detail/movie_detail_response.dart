import 'movie_detail.dart';

class MovieDetailResponse {
  final MovieDetail movieDetail;
  final String error;

  MovieDetailResponse({
    required this.movieDetail,
    required this.error,
  });

  MovieDetailResponse.fromJson(Map<String, dynamic> json) :
    movieDetail = MovieDetail.fromJson(json),
    error = "";

  MovieDetailResponse.withError(String errorVal) :
    movieDetail = MovieDetail.empty,
    error = errorVal;
}
