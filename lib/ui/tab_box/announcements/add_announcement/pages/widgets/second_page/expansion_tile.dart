import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';

class ExpansionTileWidget extends StatefulWidget {
  ExpansionTileWidget({
    super.key,
    required this.selectedFromWhere,
    required this.selectFromWhereText,
  });

  int selectedFromWhere;
  String selectFromWhereText;

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: UniqueKey(),
      title: Text(
        widget.selectFromWhereText == ""
            ? "Qayerdan turib ishlaysiz"
            : widget.selectFromWhereText,
        style: MyTextStyle.sfProMedium.copyWith(
          fontSize: 18,
          color: widget.selectFromWhereText == ""
              ? MyColors.C_2C557D
              : MyColors.C_039D57,
        ),
      ),
      children: [
        TextButton(
          onPressed: () {
            widget.selectedFromWhere = 1;
            widget.selectFromWhereText = "Uydan";
            context.read<AnnouncementCubit>().state.fields["from_where"] =
                widget.selectedFromWhere;
            setState(
              () => {},
            );
          },
          child: Text(
            "Uydan",
            style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.selectedFromWhere = 2;
            widget.selectFromWhereText = "Ofisdan";
            context.read<AnnouncementCubit>().state.fields["from_where"] =
                widget.selectedFromWhere;
            setState(
              () => {},
            );
          },
          child: Text(
            "Ofisdan",
            style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.selectedFromWhere = 3;
            widget.selectFromWhereText = "Har qanday";
            context.read<AnnouncementCubit>().state.fields["from_where"] =
                widget.selectedFromWhere;
            setState(
              () => {},
            );
          },
          child: Text(
            "Har qanday",
            style: MyTextStyle.sfProMedium.copyWith(fontSize: 18),
          ),
        ),
      ],
    );
    ;
  }
}
