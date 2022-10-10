import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/select_address_with_map.dart';
import 'package:ish_top/ui/widgets/universal_text_input.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

class AnnFieldsOne extends StatefulWidget {
  const AnnFieldsOne({Key? key}) : super(key: key);

  @override
  State<AnnFieldsOne> createState() => _AnnFieldsOneState();
}

class _AnnFieldsOneState extends State<AnnFieldsOne> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementCubit, AnnouncementState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Text("Your Personal Information",
                    style: MyTextStyle.sfProBlack.copyWith(fontSize: 20)),
              ),
              const SizedBox(
                height: 12,
              ),
              UniversalTextInput(
                caption: "FISH",
                onChanged: (value) {
                  if (value.length > 3) {
                    context.read<AnnouncementCubit>().updateCurrentItem(
                          fieldValue: value,
                          fieldKey: "full_name",
                        );
                  }
                },
                hintText: "Falonchiyev Pistonchi",
                initialText: context
                    .watch<AnnouncementCubit>()
                    .state
                    .fields["full_name"],
                keyBoardType: TextInputType.text,
              ),
              const SizedBox(
                height: 12,
              ),
              UniversalTextInput(
                caption: "Yosh",
                onChanged: (value) {
                  if (value.length > 1) {
                    context.read<AnnouncementCubit>().updateCurrentItem(
                          fieldValue: value,
                          fieldKey: "age",
                        );
                  }
                },
                hintText: "20",
                initialText: context
                    .watch<AnnouncementCubit>()
                    .state
                    .fields["age"]
                    .toString(),
                keyBoardType: TextInputType.number,
              ),
              const SizedBox(
                height: 12,
              ),
              UniversalTextInput(
                caption: "Phone number",
                onChanged: (value) {
                  if (value.length > 13) {
                    context.read<AnnouncementCubit>().updateCurrentItem(
                          fieldValue: value,
                          fieldKey: "phone_number",
                        );
                  }
                },
                hintText: "+998 99",
                initialText: context
                    .watch<AnnouncementCubit>()
                    .state
                    .fields["phone_number"]
                    .toString(),
                keyBoardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 12,
              ),
              UniversalTextInput(
                caption: "Telegram Url",
                onChanged: (value) {
                  if (value.length > 13) {
                    context.read<AnnouncementCubit>().updateCurrentItem(
                          fieldValue: value,
                          fieldKey: "telegram_url",
                        );
                  }
                },
                hintText: "@falonchi95",
                initialText: context
                    .watch<AnnouncementCubit>()
                    .state
                    .fields["telegram_url"]
                    .toString(),
                keyBoardType: TextInputType.text,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: UniversalTextInput(
                      caption: "Address",
                      onChanged: (value) {
                        if (value.length > 5) {
                          context.read<AnnouncementCubit>().updateCurrentItem(
                                fieldValue: value,
                                fieldKey: "address",
                              );
                        }
                      },
                      hintText: "Tashkent.sh",
                      initialText: context
                          .watch<AnnouncementCubit>()
                          .state
                          .fields["telegram_url"]
                          .toString(),
                      keyBoardType: TextInputType.streetAddress,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GoogleMapView(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.location_on_rounded,
                        size: 70,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
