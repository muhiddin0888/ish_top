import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/ui/widgets/universal_text_input.dart';
import 'package:ish_top/utils/constants.dart';
import 'package:ish_top/utils/icon.dart';
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
              const SizedBox(
                height: 12,
              ),
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
              const SizedBox(
                height: 12,
              ),
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
              const SizedBox(
                height: 12,
              ),
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
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        context
                                    .read<AnnouncementCubit>()
                                    .state
                                    .fields['address'] ==
                                ""
                            ? "Address is not selected"
                            : context
                                .read<AnnouncementCubit>()
                                .state
                                .fields['address'],
                        style: MyTextStyle.sfProMedium.copyWith(fontSize: 15),
                      ),
                    ),
                    // Expanded(
                    //   flex: 5,
                    //   child: UniversalTextInput(
                    //     caption: "Manzil",
                    //     onChanged: (value) {
                    //       if (value.length > 5) {
                    //         context.read<AnnouncementCubit>().updateCurrentItem(
                    //               fieldValue:
                    //                   BlocProvider.of<LocationCubit>(context)
                    //                       .selectedLocationName,
                    //               fieldKey: "address",
                    //             );
                    //       }
                    //     },
                    //     hintText: "Tashkent.sh",
                    //     initialText: context
                    //         .watch<LocationCubit>()
                    //         .selectedLocationName
                    //         .toString(),
                    //     keyBoardType: TextInputType.streetAddress,
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          googleMapView,
                          arguments: (addressName) {
                            setState(() {
                              context
                                  .read<AnnouncementCubit>()
                                  .updateCurrentItem(
                                    fieldValue: addressName,
                                    fieldKey: 'address',
                                  );
                            });
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[100],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          MyIcons.chooseLocation,
                          scale: 8.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
