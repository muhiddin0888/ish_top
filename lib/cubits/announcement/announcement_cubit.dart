import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ish_top/data/models/announcement/announcement_model.dart';
import 'package:ish_top/data/repositories/announcement/announcement_repository.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit({
    required this.announcementRepository,
  }) : super(
          AnnouncementState(
            announcements: [],
            status: FormzStatus.pure,
            errorText: '',
            fields: {
              "announcement_id": "",
              "full_name": "",
              "age": 0,
              "phone_number": "",
              "telegram_url": "",
              "knowledge": "",
              "level": "",
              "address": "",
              "aim": "",
              "created_at": DateTime.now().toString(),
              "category_id": "",
              "user_id": "",
              "job_title": "",
              "description": "",
              "job_type": 0,
              "expected_salary": "",
              "time_to_contact": "",
              "cv_url": "",
              "from_where": 0,
              "is_valid": false
            },
          ),
        );

  final AnnouncementRepository announcementRepository;

  late StreamSubscription _subscriptionAll;
  late StreamSubscription _subscriptionByCategory;

  Future<void> listenToAnnouncements() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    _subscriptionAll = announcementRepository.getAnnouncements().listen(
      (announcements) {
        emit(state.copyWith(announcements: announcements));
      },
      onError: (error) {
        emit(state.copyWith(errorText: error.toString()));
      },
    );
  }

  Future<void> listenToAnnouncementsByCategory(
      {required String categoryId}) async {
    _subscriptionAll.pause();
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    _subscriptionByCategory = announcementRepository
        .getAnnouncementsByCategory(categoryId: categoryId)
        .listen(
      (announcements) {
        emit(state.copyWith(announcements: announcements));
      },
      onError: (error) {
        emit(state.copyWith(errorText: error.toString()));
      },
    );
  }

  Future<void> addAnnouncement() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await announcementRepository.postAnnouncement(
        announcementJson: state.fields,
      );
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
      ));
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void updateCurrentItem({
    required dynamic fieldValue,
    required String fieldKey,
  }) {
    var map = state.fields;
    map[fieldKey] = fieldValue;
    print({"MAP DATA:${map}"});
    emit(state.copyWith(fields: map));
  }

  void pauseCategoryStream() {
    _subscriptionByCategory.pause();
  }

  @override
  Future<void> close() {
    _subscriptionAll.cancel();
    _subscriptionByCategory.cancel();
    return super.close();
  }
}
