import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/person/person.dart';
import '../../repos/movie_repo.dart';

part 'persons_state.dart';

class PersonsCubit extends Cubit<PersonsState> {
  final MovieRepo repo;

  PersonsCubit({required this.repo}) : super(const PersonsState.loading());

  Future<void> getPersons() async {
    try {
      final response = await repo.getPersons();
      emit(PersonsState.success(response.persons));
    } on Exception {
      emit(const PersonsState.failure());
    }
  }
}
