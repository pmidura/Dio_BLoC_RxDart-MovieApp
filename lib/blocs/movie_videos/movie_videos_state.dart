part of 'movie_videos_cubit.dart';

enum ListStatus {
  loading,
  success,
  failure,
}

class MovieVideosState extends Equatable {
  final ListStatus status;
  final List<Video> videos;

  const MovieVideosState._({
    this.status = ListStatus.loading,
    this.videos = const <Video>[],
  });

  const MovieVideosState.loading() : this._();

  const MovieVideosState.success(List<Video> videos) :
    this._(status: ListStatus.success, videos: videos);

  const MovieVideosState.failure() : this._(status: ListStatus.failure);

  @override
  List<Object?> get props => [status, videos];
}
