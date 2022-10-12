part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState({
    required this.status,
    required this.errorText,
    required this.locationName,
    required this.latLng,
  });

  final FormzStatus status;
  final String errorText;
  final String locationName;
  final LatLng latLng;

  LocationState copyWith({
    FormzStatus? status,
    String? errorText,
    String? locationName,
    LatLng? latLng,
  }) {
    return LocationState(
      errorText: errorText ?? this.errorText,
      status: status ?? this.status,
      locationName: locationName ?? this.locationName,
      latLng: latLng ?? this.latLng,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorText,
        latLng,
        locationName,
      ];
}
