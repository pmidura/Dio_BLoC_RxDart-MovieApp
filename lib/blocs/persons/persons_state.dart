part of 'persons_cubit.dart';

enum ListStatus {
  loading,
  success,
  failure,
}

class PersonsState extends Equatable {
  final ListStatus status;
  final List<Person> persons;

  const PersonsState._({
    this.status = ListStatus.loading,
    this.persons = const <Person>[],
  });

  const PersonsState.loading() : this._();

  const PersonsState.success(List<Person> persons) :
    this._(status: ListStatus.success, persons: persons);

  const PersonsState.failure() : this._(status: ListStatus.failure);

  @override
  List<Object?> get props => [status, persons];
}
