part of 'casts_cubit.dart';

enum ListStatus {
  loading,
  success,
  failure,
}

class CastsState extends Equatable {
  final ListStatus status;
  final List<Cast> casts;

  const CastsState._({
    this.status = ListStatus.loading,
    this.casts = const <Cast>[],
  });

  const CastsState.loading() : this._();

  const CastsState.success(List<Cast> casts) :
    this._(status: ListStatus.success, casts: casts);

  const CastsState.failure() : this._(status: ListStatus.failure);
  
  @override
  List<Object?> get props => [status, casts];
}
