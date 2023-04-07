import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../models/cast_response.dart';
import '../repos/movie_repo.dart';

class CastsBloc {
  final MovieRepo _repo = MovieRepo();
  final BehaviorSubject<CastResponse> _subject = BehaviorSubject<CastResponse>();

  getCasts(int id) async {
    CastResponse response = await _repo.getCasts(id);
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

  BehaviorSubject<CastResponse> get subject => _subject;
}

final castsBloc = CastsBloc();