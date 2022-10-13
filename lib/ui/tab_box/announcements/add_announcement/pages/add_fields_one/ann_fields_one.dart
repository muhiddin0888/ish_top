import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/cubits/location/location_cubit.dart';
import 'package:ish_top/data/repositories/location/location_repository.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_one/select_address_with_map.dart';
import 'package:ish_top/ui/widgets/universal_text_input.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

class AnnFieldsOne extends StatefulWidget {
  const AnnFieldsOne({Key? key}) : super(key: key);

  @override
  State<AnnFieldsOne> createState() => _AnnFieldsOneState();
}

class _AnnFieldsOneState extends State<AnnFieldsOne> {
  bool positionLoader = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementCubit, AnnouncementState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Center(
                child: Text("Your Personal Information",
                    style: MyTextStyle.sfProBlack
                        .copyWith(fontSize: 20, color: MyColors.primaryColor)),
              ),
              const SizedBox(height: 12),
              UniversalTextInput(
                caption: "FISH",
                onChanged: (value) {
                  context.read<AnnouncementCubit>().updateCurrentItem(
                        fieldValue: value,
                        fieldKey: "full_name",
                      );
                },
                hintText: "Falonchiyev Pistonchi",
                initialText: context
                    .watch<AnnouncementCubit>()
                    .state
                    .fields["full_name"],
                keyBoardType: TextInputType.text,
              ),
              const SizedBox(height: 12),
              UniversalTextInput(
                caption: "Yosh",
                onChanged: (value) {
                  context.read<AnnouncementCubit>().updateCurrentItem(
                        fieldValue: int.tryParse(value),
                        fieldKey: "age",
                      );
                },
                hintText: "20",
                initialText: context
                    .watch<AnnouncementCubit>()
                    .state
                    .fields["age"]
                    .toString(),
                keyBoardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              UniversalTextInput(
                caption: "Telefon no'mer",
                onChanged: (value) {
                  context.read<AnnouncementCubit>().updateCurrentItem(
                        fieldValue: value,
                        fieldKey: "phone_number",
                      );
                },
                hintText: "+998 99",
                initialText: context
                    .watch<AnnouncementCubit>()
                    .state
                    .fields["phone_number"]
                    .toString(),
                keyBoardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              UniversalTextInput(
                caption: "Telegram Url",
                onChanged: (value) {
                  context.read<AnnouncementCubit>().updateCurrentItem(
                        fieldValue: value,
                        fieldKey: "telegram_url",
                      );
                },
                hintText: "@forExample",
                initialText: context
                    .watch<AnnouncementCubit>()
                    .state
                    .fields["telegram_url"]
                    .toString(),
                keyBoardType: TextInputType.text,
              ),
              const SizedBox(height: 12),
              UniversalTextInput(
                caption: "Manzil",
                onChanged: (value) {
                  context.read<AnnouncementCubit>().updateCurrentItem(
                        fieldValue: value,
                        fieldKey: "address",
                      );
                },
                hintText: "Tashkent.sh",
                initialText: state.fields["address"],
                keyBoardType: TextInputType.streetAddress,
              ),
              positionLoader
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : TextButton(
                      onPressed: mapLogic,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Xaritadan ko'rsatish",
                            style: MyTextStyle.sfProRegular.copyWith(
                                fontSize: 15,
                                color: MyColors.primaryColor,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Icon(
                            Icons.add_location,
                            color: MyColors.primaryColor,
                            size: 30,
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    )
            ],
          ),
        );
      },
    );
  }

  void mapLogic() async {
    setState(() {
      positionLoader = true;
    });
    var position = await RepositoryProvider.of<LocationRepository>(context)
        .determinePosition();
    await BlocProvider.of<LocationCubit>(context).getLocationName(
      lat: position.latitude,
      long: position.longitude,
    );
    await BlocProvider.of<LocationCubit>(context)
        .updateCurrentPosition(position);
    setState(() {
      positionLoader = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GoogleMapView(
            latLng: LatLng(position.latitude, position.longitude),
            callback: () {
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
