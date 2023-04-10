import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cast/cast.dart';
import '../../repos/movie_repo.dart';

part 'casts_state.dart';

class CastsCubit extends Cubit<CastsState> {
  final MovieRepo repo;
  
  CastsCubit({required this.repo}) : super(const CastsState.loading());

  Future<void> fetchCasts(int id) async {
    try {
      final response = await repo.getCasts(id);
      emit(CastsState.success(response.casts));
    } on Exception {
      emit(const CastsState.failure());
    }
  }
}
