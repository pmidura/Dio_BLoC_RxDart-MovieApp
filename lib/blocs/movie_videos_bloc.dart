import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../models/video_response.dart';
import '../repos/movie_repo.dart';

class MovieVideosBloc {
  final MovieRepo _repo = MovieRepo();
  final BehaviorSubject<VideoResponse> _subject = BehaviorSubject<VideoResponse>();
  
  getMovieVideos(int id) async {
    VideoResponse response = await _repo.getMovieVideos(id);
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

  BehaviorSubject<VideoResponse> get subject => _subject;
}

final movieVideosBloc = MovieVideosBloc();