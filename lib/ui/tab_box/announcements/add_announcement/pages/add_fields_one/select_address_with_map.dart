import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/cubits/location/location_cubit.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({
    super.key,
    required this.latLng,
    required this.callback,
  });

  final LatLng latLng;
  final VoidCallback callback;

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  bool isIdle = false;

  late final GoogleMapController googleMapController;
  late CameraPosition currentCameraPosition;

  @override
  void initState() {
    currentCameraPosition = CameraPosition(
      target: LatLng(
        widget.latLng.latitude,
        widget.latLng.longitude,
      ),
      zoom: 14,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select address"),
      ),
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
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
                        context.read<LocationCubit>().getLocationName(
                              lat: currentCameraPosition.target.latitude,
                              long: currentCameraPosition.target.longitude,
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
                        state.locationName.isEmpty
                            ? "Address not selected"
                            : state.locationName,
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
                          print("NNN:${state.locationName}");
                          BlocProvider.of<AnnouncementCubit>(context)
                              .updateCurrentItem(
                            fieldValue: state.locationName,
                            fieldKey: 'address',
                          );
                          widget.callback.call();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.5,
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
                            shadowColor: MaterialStatePropertyAll(Colors.grey),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        color: Colors.blue,
                        onPressed: () async {
                          googleMapController.animateCamera(
                            CameraUpdate.newLatLngZoom(
                              LatLng(
                                state.latLng.latitude,
                                state.latLng.longitude,
                              ),
                              16,
                            ),
                          );
                          context.read<LocationCubit>().getLocationName(
                                lat: state.latLng.latitude,
                                long: state.latLng.longitude,
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
        },
      ),
    );
  }
}
