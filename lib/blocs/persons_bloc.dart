import 'package:rxdart/rxdart.dart';

import '../models/person_response.dart';
import '../repos/movie_repo.dart';

class PersonsBloc {
  final MovieRepo _repo = MovieRepo();
  final BehaviorSubject<PersonResponse> _subject = BehaviorSubject<PersonResponse>();

  getPersons() async {
    PersonResponse response = await _repo.getPersons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}

final personsBloc = PersonsBloc();
