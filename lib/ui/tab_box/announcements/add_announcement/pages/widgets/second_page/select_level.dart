import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/select_level.dart';

class SelectLevelButtonsWidget extends StatefulWidget {
  SelectLevelButtonsWidget({super.key, required this.selectLevel});
  int selectLevel;

  @override
  State<SelectLevelButtonsWidget> createState() =>
      _SelectLevelButtonsWidgetState();
}

class _SelectLevelButtonsWidgetState extends State<SelectLevelButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SelectLevelWidget(
            onTap: () {
              widget.selectLevel = 0;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Internship";
            },
            backGroundColor: widget.selectLevel == 0 ? Color(0xff356899) : null,
            border: widget.selectLevel == 0
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor:
                widget.selectLevel == 0 ? Colors.white : Color(0xff95969d),
            text: widget.selectLevel == 0 ? 'Internship 👶' : 'Internship',
            textSize: widget.selectLevel == 0 ? 18 : 14,
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: widget.selectLevel == 1 ? 18 : 14,
            onTap: () {
              widget.selectLevel = 1;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Junior";
            },
            backGroundColor: widget.selectLevel == 1 ? Color(0xff356899) : null,
            border: widget.selectLevel == 1
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor:
                widget.selectLevel == 1 ? Colors.white : Color(0xff95969d),
            text: widget.selectLevel == 1 ? 'Junior 👦' : 'Junior',
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: widget.selectLevel == 2 ? 18 : 14,
            onTap: () {
              widget.selectLevel = 2;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Middle";
            },
            backGroundColor: widget.selectLevel == 2 ? Color(0xff356899) : null,
            border: widget.selectLevel == 2
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor:
                widget.selectLevel == 2 ? Colors.white : Color(0xff95969d),
            text: widget.selectLevel == 2 ? 'Middle 👨' : 'Middle',
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: widget.selectLevel == 3 ? 18 : 14,
            onTap: () {
              widget.selectLevel = 3;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Senior";
            },
            backGroundColor: widget.selectLevel == 3 ? Color(0xff356899) : null,
            border: widget.selectLevel == 3
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor:
                widget.selectLevel == 3 ? Colors.white : Color(0xff95969d),
            text: widget.selectLevel == 3 ? 'Senior 👨‍🦱' : 'Senior',
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: widget.selectLevel == 4 ? 18 : 14,
            onTap: () {
              widget.selectLevel = 4;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Expert";
            },
            backGroundColor: widget.selectLevel == 4 ? Color(0xff356899) : null,
            border: widget.selectLevel == 4
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor:
                widget.selectLevel == 4 ? Colors.white : Color(0xff95969d),
            text: widget.selectLevel == 4 ? 'Expert 👨‍🦲' : 'Expert',
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: widget.selectLevel == 5 ? 18 : 14,
            onTap: () {
              widget.selectLevel = 5;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Team Lead";
            },
            backGroundColor: widget.selectLevel == 5 ? Color(0xff356899) : null,
            border: widget.selectLevel == 5
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor:
                widget.selectLevel == 5 ? Colors.white : Color(0xff95969d),
            text: widget.selectLevel == 5 ? 'Team Lead 👨‍💻' : 'Team Lead',
          ),
          SizedBox(width: 5),
          SelectLevelWidget(
            textSize: widget.selectLevel == 6 ? 18 : 14,
            onTap: () {
              widget.selectLevel = 6;
              setState(
                () => {},
              );
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Project Manager";
            },
            backGroundColor: widget.selectLevel == 6 ? Color(0xff356899) : null,
            border: widget.selectLevel == 6
                ? null
                : Border.all(width: 1, color: Color(0xff95969d)),
            textColor:
                widget.selectLevel == 6 ? Colors.white : Color(0xff95969d),
            text: widget.selectLevel == 6
                ? 'Project Manager 👴'
                : 'Project Manager',
          ),
        ],
      ),
    );
  }
}
