import 'package:bloc/bloc.dart';
import 'package:ish_top/data/repositories/announcement/announcement_repository.dart';
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
  final HelperRepository helperRepository;
}
