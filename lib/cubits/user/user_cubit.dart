import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ish_top/data/models/users/user_model.dart';
import 'package:ish_top/data/repositories/user/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.userRepository,
  }) : super(
          UserState(
            userModel: UserModel(
              imageUrl: '',
              createdAt: DateTime.now(),
              fullName: '',
              phoneNumber: '',
              userId: '',
            ),
            status: FormzStatus.pure,
            errorText: "",
          ),
        );

  final UserRepository userRepository;

  void postUser(UserModel userModel) {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      userRepository.postUser(userModel: userModel);
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        userModel: userModel,
      ),);
    } catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorText: e.toString(),
      ),);
    }
  }

  void fetchUser(String docId)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
     var userModel = await userRepository.getUserData(docId: docId);
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        userModel: userModel,
      ),);
    } catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorText: e.toString(),
      ),);
    }
  }



  void updateUser(UserModel userModel) {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      userRepository.updateUser(userModel: userModel);
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        userModel: userModel,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorText: e.toString(),
      ));
    }
  }
}
