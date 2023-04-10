part of 'movies_by_genre_cubit.dart';

enum ListStatus {
  loading,
  success,
  failure,
}

class MoviesByGenreState extends Equatable {
  final ListStatus status;
  final List<Movie> movies;

  const MoviesByGenreState._({
    this.status = ListStatus.loading,
    this.movies = const <Movie>[],
  });

  const MoviesByGenreState.loading() : this._();

  const MoviesByGenreState.success(List<Movie> movies) :
    this._(status: ListStatus.success, movies: movies);

  const MoviesByGenreState.failure() : this._(status: ListStatus.failure);

  @override
  List<Object?> get props => [status, movies];
}
