part of 'movie_similar_cubit.dart';

enum ListStatus {
  loading,
  success,
  failure,
}

class MovieSimilarState extends Equatable {
  final ListStatus status;
  final List<Movie> movies;

  const MovieSimilarState._({
    this.status = ListStatus.loading,
    this.movies = const <Movie>[],
  });

  const MovieSimilarState.loading() : this._();

  const MovieSimilarState.success(List<Movie> movies) :
    this._(status: ListStatus.success, movies: movies);

  const MovieSimilarState.failure() : this._(status: ListStatus.failure);

  @override
  List<Object?> get props => [status, movies];
}
