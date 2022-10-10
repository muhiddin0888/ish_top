part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({
    required this.userModel,
    required this.status,
    required this.errorText,
  });

  final FormzStatus status;
  final UserModel userModel;
  final String errorText;

  UserState copyWith({
    FormzStatus? status,
    UserModel? userModel,
    String? errorText,
  }) =>
      UserState(
        status: status ?? this.status,
        userModel: userModel ?? this.userModel,
        errorText: errorText ?? this.errorText,
      );

  @override
  List<Object?> get props => [
        status,
        userModel,
        errorText,
      ];
}
