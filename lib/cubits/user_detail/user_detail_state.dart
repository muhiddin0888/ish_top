part of 'user_detail_cubit.dart';

class UserDetailState extends Equatable {
  const UserDetailState({
    required this.errorText,
    required this.status,
    required this.users,
  });
  final FormzStatus status;
  final String errorText;
  final List<UserModel> users;

  UserDetailState copyWith({
    String? errorText,
    FormzStatus? status,
    List<UserModel>? users,
  }) =>
      UserDetailState(
        errorText: errorText ?? this.errorText,
        status: status ?? this.status,
        users: users ?? this.users,
      );
  @override
  List<Object> get props => [status, errorText, users];
}
