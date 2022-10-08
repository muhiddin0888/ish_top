import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/ui/widgets/universal_text_input.dart';

class AnnFieldsOne extends StatefulWidget {
  const AnnFieldsOne({Key? key}) : super(key: key);

  @override
  State<AnnFieldsOne> createState() => _AnnFieldsOneState();
}

class _AnnFieldsOneState extends State<AnnFieldsOne> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
      builder: (context, state) {
        return Column(
          children: [
            UniversalTextInput(
              onChanged: (value) {
                if (value.length > 3) {
                  context.read<AnnouncementCubit>().updateCurrentItem(
                        fieldValue: value,
                        fieldKey: "full_name",
                      );
                }
              },
              hintText: "First Name",
              initialText:
                  context.watch<AnnouncementCubit>().state.fields["full_name"],
            ),

            Text("Full name"),
            Text("Age"),
            Text("Phone Number"),
            Text("Telegram Url"),
            Text("Address"),
          ],
        );
      },
    ));
  }
}
