import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ish_top/data/repositories/location/location_repository.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required this.locationRepository})
      : super(
          const LocationState(
            status: FormzStatus.submissionInProgress,
            errorText: "",
            locationName: '',
            latLng: LatLng(0, 0),
          ),
        );

  LocationRepository locationRepository;
  String errorText = "";

  updateCurrentPosition(Position position) async {
    emit(
      state.copyWith(
        latLng: LatLng(
          position.latitude,
          position.longitude,
        ),
      ),
    );
  }

  getLocationName({required double lat, required double long}) async {
    var selectedLocationName =
        await locationRepository.getLocationName("$long,$lat");
    emit(
      state.copyWith(
        status: FormzStatus.submissionSuccess,
        locationName: selectedLocationName,
      ),
    );
  }
}
