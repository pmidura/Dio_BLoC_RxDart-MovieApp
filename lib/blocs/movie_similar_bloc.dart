import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../models/movie_response.dart';
import '../repos/movie_repo.dart';

class SimilarMoviesBloc {
  final MovieRepo _repo = MovieRepo();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getSimilarMovies(int id) async {
    MovieResponse response = await _repo.getSimilarMovies(id);
    _subject.sink.add(response);
  }

  void drainStream() async {
    await _subject.drain();
  }
  
  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final similarMoviesBloc = SimilarMoviesBloc();