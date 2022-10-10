part of 'vacancy_cubit.dart';

@immutable
abstract class VacancyState {}

class VacancyInitial extends VacancyState {}

class GetVacancyProgress extends VacancyState{}

class GetVacancyInSuccess extends VacancyState{

  GetVacancyInSuccess({required this.vacancies});

  final List<VacancyModel> vacancies;
}

class GetVacancyInFailure extends VacancyState {
  final String errorText;
  GetVacancyInFailure({required this.errorText});
}



