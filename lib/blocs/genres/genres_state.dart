part of 'genres_cubit.dart';

enum ListStatus {
  loading,
  success,
  failure,
}

class GenresState extends Equatable {
  final ListStatus status;
  final List<Genre> genres;
  
  const GenresState._({
    this.status = ListStatus.loading,
    this.genres = const <Genre>[],
  });

  const GenresState.loading() : this._();

  const GenresState.success(List<Genre> genres) :
    this._(status: ListStatus.success, genres: genres);

  const GenresState.failure() : this._(status: ListStatus.failure);

  @override
  List<Object?> get props => [status, genres];
}
