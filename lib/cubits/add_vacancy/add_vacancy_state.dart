part of 'add_vacancy_cubit.dart';

class VacancyState extends Equatable {
  const VacancyState({
    required this.fields,
  });

  final Map<String, dynamic> fields;

  VacancyState copyWith({
    Map<String, dynamic>? fields,
  }) =>
      VacancyState(
        fields: fields ?? this.fields,
      );

  @override
  List<Object?> get props => [
        fields,
      ];
}
