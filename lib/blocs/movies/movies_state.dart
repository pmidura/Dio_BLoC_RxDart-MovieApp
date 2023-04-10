part of 'movies_cubit.dart';

enum ListStatus {
  loading,
  success,
  failure,
}

class MoviesState extends Equatable {
  final ListStatus status;
  final List<Movie> movies;
  
  const MoviesState._({
    this.status = ListStatus.loading,
    this.movies = const <Movie>[],
  });

  const MoviesState.loading() : this._();

  const MoviesState.success(List<Movie> movies) :
    this._(status: ListStatus.success, movies: movies);

  const MoviesState.failure() : this._(status: ListStatus.failure);

  @override
  List<Object?> get props => [status, movies];
}
