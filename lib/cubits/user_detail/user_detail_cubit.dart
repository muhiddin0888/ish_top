import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ish_top/data/models/announcement/announcement_model.dart';
import 'package:ish_top/data/models/users/user_model.dart';
import 'package:ish_top/data/repositories/helper/helper_repository.dart';

part 'user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  final HelperRepository helperRepository;
  UserDetailCubit({required this.helperRepository})
      : super(
          const UserDetailState(
            errorText: "",
            status: FormzStatus.pure,
            users: [],
          ),
        );
  String image = "Kemadi";
  Future<String> getUserImageById({
    required AnnouncementModel announcement,
    required List<UserModel> users,
  }) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      image = await helperRepository.getUserDetailById(
          announcement: announcement, users: users);
      emit(state.copyWith(status: FormzStatus.submissionSuccess, users: users));
      return image;
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorText: e.toString()));
      throw Exception(e);
    }
  }
}
