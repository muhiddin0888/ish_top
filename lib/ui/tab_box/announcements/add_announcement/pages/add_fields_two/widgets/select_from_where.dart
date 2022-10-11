import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/utils/style.dart';

class SelectFromWhere extends StatefulWidget {
  const SelectFromWhere({super.key});

  @override
  State<SelectFromWhere> createState() => _SelectFromWhereState();
}

class _SelectFromWhereState extends State<SelectFromWhere> {
  @override
  Widget build(BuildContext context) {
    String fromWhere = getFromWhereMean(
        context.read<AnnouncementCubit>().state.fields['from_where']);
    return ExpansionTile(
      key: UniqueKey(),
      title: Text(
        fromWhere,
        style: MyTextStyle.sfProMedium.copyWith(
          fontSize: 18,
        ),
      ),
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              fromWhere = getFromWhereMean(0);
            });
          },
          child: Text(
            "Uydan",
            style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(
              () {
                setState(() {
                  fromWhere = getFromWhereMean(1);
                });
              },
            );
          },
          child: Text(
            "Ofisdan",
            style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(
              () {
                setState(() {
                  fromWhere = getFromWhereMean(2);
                });
              },
            );
          },
          child: Text(
            "Har qanday",
            style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
          ),
        ),
      ],
    );
  }

  String getFromWhereMean(int number) {
    context.read<AnnouncementCubit>().updateCurrentItem(
          fieldValue: number,
          fieldKey: 'from_where',
        );
    if (number == 0) {
      return "Uydan";
    } else if (number == 1) {
      return "Ofisdan";
    } else {
      return "Har qanday";
    }
  }
}
