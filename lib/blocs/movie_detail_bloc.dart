import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../models/movie_detail_response.dart';
import '../repos/movie_repo.dart';

class MovieDetailBloc {
  final MovieRepo _repo = MovieRepo();
  final BehaviorSubject<MovieDetailResponse> _subject = BehaviorSubject<MovieDetailResponse>();
  
  getMovieDetail(int id) async {
    MovieDetailResponse response = await _repo.getMovieDetail(id);
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

  BehaviorSubject<MovieDetailResponse> get subject => _subject;
}

final movieDetailBloc = MovieDetailBloc();