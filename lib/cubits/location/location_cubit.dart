import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ish_top/data/repositories/location/location_repository.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required this.locationRepository})
      : super(
          const LocationState(
              status: FormzStatus.submissionInProgress,
              errorText: "",
              locationName: ''),
        ) {
    fetchCurrentPosition();
  }

  LocationRepository locationRepository;

  String errorText = "";
  bool isLoading = false;
  Position? position;
  String currentLocationName = '';
  String selectedLocationName = '';

  fetchCurrentPosition() async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );
    try {
      position = await locationRepository.determinePosition();
      if (position != null) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
    } catch (error) {
      errorText = error.toString();
    }
  }

  getLocationName() async {
    currentLocationName = await locationRepository
        .getLocationName("${position!.longitude},${position!.latitude}");
    debugPrint(currentLocationName);
    emit(
      state.copyWith(
        status: FormzStatus.submissionSuccess,
        locationName: currentLocationName,
      ),
    );
  }

  viewSelectedLocationName({required double lat, required double long}) async {
    selectedLocationName =
        await locationRepository.getLocationName("$long,$lat");
    emit(
      state.copyWith(
        status: FormzStatus.submissionSuccess,
        locationName: selectedLocationName,
      ),
    );
  }
}
