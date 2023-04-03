import 'package:rxdart/rxdart.dart';

import '../models/movie_response.dart';
import '../repos/movie_repo.dart';

class NowPlayingBloc {
  final MovieRepo _repo = MovieRepo();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getNowPlaying() async {
    MovieResponse response = await _repo.getPlayingMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final nowPlayingBloc = NowPlayingBloc();
