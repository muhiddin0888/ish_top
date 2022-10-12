import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/cubits/location/location_cubit.dart';
import 'package:ish_top/utils/icon.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  bool isIdle = true;

  late final GoogleMapController googleMapController;

  CameraPosition currentCameraPosition = const CameraPosition(
      target: LatLng(41.286393176986685, 69.20411702245474), zoom: 14);

  @override
  Widget build(BuildContext context) {
    Position? position = context.watch<LocationCubit>().position;

    String locationName = context.watch<LocationCubit>().selectedLocationName;
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
                              zoomControlsEnabled: false,
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
                        Positioned(
                          right: 10,
                          bottom: 150,
                          child: IconButton(
                            style: const ButtonStyle(
                                elevation: MaterialStatePropertyAll(3.5),
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
                            },
                            icon: const Icon(
                              Icons.my_location,
                              size: 30,
                            ),
                          ),
                        ),
                        Positioned(
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
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              locationName,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.blue),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 30,
                          right: 30,
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<AnnouncementCubit>()
                                  .state
                                  .fields["address"] = locationName;
                              debugPrint(context
                                  .read<AnnouncementCubit>()
                                  .state
                                  .fields["address"]);
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
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
                                      fontSize: 20),
                                ),
                              ),
                            ),
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
