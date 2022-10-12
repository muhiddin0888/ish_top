import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/select_level.dart';
import '../../../../../../../cubits/announcement/announcement_cubit.dart';

class SelectLevelItem extends StatelessWidget {
  const SelectLevelItem({
    super.key,
    required this.selectLevel,
    required this.importSelectedLevel,
  });
  final ValueChanged<String> importSelectedLevel;
  final String selectLevel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SelectLevelWidget(
            isSelected: selectLevel == "Internship",
            onTap: () {
              importSelectedLevel.call('Internship');
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Internship";
            },
            text: selectLevel == 'Internship' ? 'Internship 👶' : 'Internship',
          ),
          const SizedBox(width: 5),
          SelectLevelWidget(
            isSelected: selectLevel == "Junior",
            onTap: () {
              importSelectedLevel.call("Junior");
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Junior";
            },
            text: selectLevel == "Junior" ? 'Junior 👦' : 'Junior',
          ),
          const SizedBox(width: 5),
          SelectLevelWidget(
            isSelected: selectLevel == 'Middle',
            onTap: () {
              importSelectedLevel.call('Middle');
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Middle";
            },
            text: selectLevel == 'Middle' ? 'Middle 👨' : 'Middle',
          ),
          const SizedBox(width: 5),
          SelectLevelWidget(
            isSelected: selectLevel == 'Senior',
            onTap: () {
              importSelectedLevel.call('Senior');
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Senior";
            },
            text: selectLevel == 'Senior' ? 'Senior 👨‍🦱' : 'Senior',
          ),
          const SizedBox(width: 5),
          SelectLevelWidget(
            isSelected: selectLevel == 'Expert',
            onTap: () {
              importSelectedLevel.call("Expert");
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Expert";
            },
            text: selectLevel == "Expert" ? 'Expert 👨‍🦲' : 'Expert',
          ),
          const SizedBox(width: 5),
          SelectLevelWidget(
            isSelected: selectLevel == "Team Lead",
            onTap: () {
              importSelectedLevel.call("Team Lead");
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Team Lead";
            },
            text: selectLevel == "Team Lead" ? 'Team Lead 👨‍💻' : 'Team Lead',
          ),
          const SizedBox(width: 5),
          SelectLevelWidget(
            isSelected: selectLevel == "Project Manager",
            onTap: () {
              importSelectedLevel.call("Project Manager");
              context.read<AnnouncementCubit>().state.fields["level"] =
                  "Project Manager";
            },
            text: selectLevel == "Project Manager" ? 'Project Manager 👴' : 'Project Manager',
          ),
        ],
      ),
    );
  }
}
