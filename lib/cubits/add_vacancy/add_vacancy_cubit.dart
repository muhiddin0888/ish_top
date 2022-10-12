import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ish_top/data/repositories/vacancy/vacancy_repository.dart';

part 'add_vacancy_state.dart';

class AddVacancyCubit extends Cubit<VacancyState> {
  AddVacancyCubit(this.vacancyRepository)
      : super(
          VacancyState(
            fields: {
              "vacancy_id": "",
              "company_name": "",
              "brand_image_url": "",
              "category_id": "",
              "user_id": "",
              "created_at": DateTime.now().toString(),
              "job_title": "",
              "required_level": "",
              "description": "",
              "job_type": 0,
              "recruiter_phone": "",
              "telegram_url": "",
              "offered_salary_from": "",
              "from_where": 0,
              "currency": "",
              "offered_salary_to": "",
            },
          ),
        );

  final VacancyRepository vacancyRepository;

  void updateCurrentItem({
    required dynamic fieldValue,
    required String fieldKey,
  }) {
    var map = state.fields;
    map[fieldKey] = fieldValue;
    print({"MAP DATA VACANCY:${map}"});
    emit(state.copyWith(fields: map));
  }

  Future<void> addVacancy() async {
    try {
      await vacancyRepository.postVacancy(json: state.fields);
      emit(
        state.copyWith(fields: {
          "vacancy_id": "",
          "company_name": "",
          "brand_image_url": "",
          "category_id": "",
          "user_id": "",
          "created_at": DateTime.now().toString(),
          "job_title": "",
          "required_level": "",
          "description": "",
          "job_type": 0,
          "recruiter_phone": "",
          "telegram_url": "",
          "offered_salary_from": "",
          "from_where": 0,
          "offered_salary_to": "",
        }),
      );
    } catch (error) {
      print(error);
    }
  }
}
