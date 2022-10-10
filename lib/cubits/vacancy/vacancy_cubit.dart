import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ish_top/data/models/vacancy/vacancy_model.dart';
import 'package:ish_top/data/repositories/helper/helper_repository.dart';
import 'package:ish_top/data/repositories/vacancy/vacancy_repository.dart';
import 'package:meta/meta.dart';

part 'vacancy_state.dart';

class VacancyCubit extends Cubit<VacancyState> {
  VacancyCubit({
    required this.helperRepository,
    required this.vacancyRepository,
  }) : super(VacancyInitial());

  final VacancyRepository vacancyRepository;

  late StreamSubscription _subscription;
  final HelperRepository helperRepository;

  Future<void> listenToVacancies() async {
    emit(GetVacancyProgress());
    _subscription = vacancyRepository.getVacancies().listen(
          (items) {
        emit(GetVacancyInSuccess(vacancies: items));
      },
      onError: (error) {
        emit(GetVacancyInFailure(errorText: error.toString()));
      },
    );
  }

  Future<void> listenToVacanciesById({required String categoryId}) async {
    emit(GetVacancyProgress());
    _subscription = vacancyRepository.getVacanciesByCategory(categoryId: categoryId).listen(
          (items) {
        emit(GetVacancyInSuccess(vacancies: items));
      },
      onError: (error) {
        emit(GetVacancyInFailure(errorText: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
