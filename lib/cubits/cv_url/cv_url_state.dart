part of 'cv_url_cubit.dart';

class CvUrlState extends Equatable {
  const CvUrlState({
    required this.cvUrl,
    this.status = FormzStatus.pure,
    this.errorText = "",
  });

  final FormzStatus status;
  final CvUrlModel cvUrl;
  final String errorText;

  CvUrlState copyWith({
    FormzStatus? status,
    CvUrlModel? cvUrl,
    String? errorText,
  }) =>
      CvUrlState(
        cvUrl: cvUrl ?? this.cvUrl,
        status: status ?? this.status,
        errorText: errorText ?? this.errorText,
      );

  @override
  List<Object> get props => [cvUrl, status, errorText];
}
