part of 'announcement_cubit.dart';

class AnnouncementState extends Equatable {
  AnnouncementState({
    required this.announcements,
    required this.status,
    required this.errorText,
    required this.fields,
  });

  final FormzStatus status;
  final List<AnnouncementModel> announcements;
  final Map<String, dynamic> fields;
  final String errorText;

  AnnouncementState copyWith({
    FormzStatus? status,
    List<AnnouncementModel>? announcements,
    String? errorText,
    Map<String, dynamic>? fields,
  }) =>
      AnnouncementState(
        status: status ?? this.status,
        announcements: announcements ?? this.announcements,
        errorText: errorText ?? this.errorText,
        fields: fields ?? this.fields,
      );

  @override
  List<Object?> get props => [status, fields, errorText, announcements];
}
