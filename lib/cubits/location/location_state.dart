part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState(
      {required this.status,
      required this.errorText,
      required this.locationName});

  final FormzStatus status;
  final String errorText;
  final String locationName;

  LocationState copyWith(
      {FormzStatus? status, String? errorText, String? locationName}) {
    return LocationState(
      errorText: errorText ?? this.errorText,
      status: status ?? this.status,
      locationName: locationName ?? this.locationName,
    );
  }

  @override
  List<Object> get props => [status, errorText];
}
