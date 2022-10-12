import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

class SelectedTimeItem extends StatelessWidget {
  const SelectedTimeItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.timeKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: MyTextStyle.sfProRegular.copyWith(fontSize: 13),
        ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(7),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 5,
                    blurRadius: 5,
                    color: Colors.grey.shade300,
                    offset: const Offset(1, 3),
                  )
                ]),
            child: Text(
              DateFormat.Hm().format(
                DateTime.parse(
                  context.watch<AnnouncementCubit>().state.fields[timeKey],
                ),
              ),
              style: MyTextStyle.sfProMedium.copyWith(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  final VoidCallback onTap;
  final String title;
  final String timeKey;
}
