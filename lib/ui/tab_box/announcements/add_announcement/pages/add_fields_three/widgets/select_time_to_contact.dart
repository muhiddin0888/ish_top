import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/utils/my_utils.dart';
Future<void> selectTimeFrom(
      {required BuildContext context, required bool isFrom}) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.parse(context
          .read<AnnouncementCubit>()
          .state
          .fields[isFrom ? 'time_to_contact_from' : 'time_to_contact_to'])),
    );
    if (selected != null) {
      if (isFrom) {
        context.read<AnnouncementCubit>().updateCurrentItem(
              fieldValue:
                  DateTime(0, 0, 0, selected.hour, selected.minute).toString(),
              fieldKey: "time_to_contact_from",
            );
      } else {
        context.read<AnnouncementCubit>().updateCurrentItem(
              fieldValue:
                  DateTime(0, 0, 0, selected.hour, selected.minute).toString(),
              fieldKey: "time_to_contact_to",
            );
      }
    } else {
      MyUtils.getMyToast(message: "Time is not selected");
    }
  }