import 'package:rxdart/rxdart.dart';

import '../models/genre_response.dart';
import '../repos/movie_repo.dart';

class GenresBloc {
  final MovieRepo _repo = MovieRepo();
  final BehaviorSubject<GenreResponse> _subject = BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse response = await _repo.getGenres();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}

final genresBloc = GenresBloc();
