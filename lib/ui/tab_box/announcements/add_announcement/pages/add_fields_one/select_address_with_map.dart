import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/cubits/location/location_cubit.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key, required this.addressName});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
  final ValueChanged<String> addressName;
}

class _GoogleMapViewState extends State<GoogleMapView> {
  bool isIdle = false;

  late final GoogleMapController googleMapController;
  CameraPosition currentCameraPosition = const CameraPosition(
      target: LatLng(41.286393176986685, 69.20411702245474), zoom: 14);

  String currentLocationName = '';
  String locationName = '';

  @override
  void initState() {
    BlocProvider.of<LocationCubit>(context).fetchCurrentPosition();
    setState(() {
      currentLocationName =
          BlocProvider.of<LocationCubit>(context).currentLocationName;
    });
    debugPrint(currentLocationName.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Position? position = context.watch<LocationCubit>().position;

    locationName = context.watch<LocationCubit>().selectedLocationName;

    debugPrint("locationName    $locationName");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select address"),
      ),
      body: position != null
          ? BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state.status == FormzStatus.submissionInProgress) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state.status == FormzStatus.submissionSuccess) {
                  currentCameraPosition = CameraPosition(
                    target: LatLng(
                      BlocProvider.of<LocationCubit>(context)
                          .position!
                          .latitude,
                      BlocProvider.of<LocationCubit>(context)
                          .position!
                          .longitude,
                    ),
                    zoom: 14,
                  );
                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: ClipRRect(
                            child: GoogleMap(
                              onTap: (a) {
                                setState(() {
                                  isIdle = false;
                                });
                              },
                              onLongPress: (argument) {
                                setState(() {
                                  isIdle = true;
                                });
                              },
                              onCameraMoveStarted: () {
                                setState(() {
                                  isIdle = true;
                                });
                              },
                              mapType: MapType.terrain,
                              initialCameraPosition: currentCameraPosition,
                              onMapCreated: (controller) =>
                                  googleMapController = controller,
                              onCameraMove: (CameraPosition position) {
                                currentCameraPosition = position;
                                setState(() {
                                  isIdle = false;
                                });
                              },
                              zoomControlsEnabled: true,
                              onCameraIdle: () {
                                setState(() {
                                  isIdle = true;
                                });
                                debugPrint("IDLE");
                                debugPrint(
                                    "LONGITUDE:${currentCameraPosition.target.longitude}");
                                debugPrint(
                                    "LATITUDE:${currentCameraPosition.target.latitude}");
                                context
                                    .read<LocationCubit>()
                                    .viewSelectedLocationName(
                                      lat:
                                          currentCameraPosition.target.latitude,
                                      long: currentCameraPosition
                                          .target.longitude,
                                    );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            width: isIdle ? 80 : 120,
                            curve: Curves.linear,
                            duration: const Duration(milliseconds: 100),
                            child: Image.asset(
                              MyIcons.mapLogo,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isIdle,
                          child: Positioned(
                            top: 20,
                            left: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 0),
                                    blurRadius: 10,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                locationName.isEmpty
                                    ? "Address not selected"
                                    : locationName,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  widget.addressName.call(locationName);
                                  context
                                      .read<LocationCubit>()
                                      .selectedLocationName = locationName;

                                  debugPrint(context
                                      .read<AnnouncementCubit>()
                                      .state
                                      .fields["address"]);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0, 0),
                                            blurRadius: 10)
                                      ],
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Center(
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                style: const ButtonStyle(
                                    elevation: MaterialStatePropertyAll(10),
                                    shadowColor:
                                        MaterialStatePropertyAll(Colors.grey),
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                color: Colors.blue,
                                onPressed: () async {
                                  googleMapController.animateCamera(
                                    CameraUpdate.newLatLngZoom(
                                      LatLng(
                                        position.latitude,
                                        position.longitude,
                                      ),
                                      16,
                                    ),
                                  );
                                  context
                                      .read<LocationCubit>()
                                      .viewSelectedLocationName(
                                        lat: position.latitude,
                                        long: position.longitude,
                                      );
                                },
                                icon: const Icon(
                                  Icons.my_location,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state.status == FormzStatus.submissionFailure) {
                  return Center(
                    child: Text(state.errorText),
                  );
                }
                return const SizedBox();
              },
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
