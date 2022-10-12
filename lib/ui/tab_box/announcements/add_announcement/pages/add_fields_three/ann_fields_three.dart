import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_three/widgets/select_time_to_contact.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/add_fields_three/widgets/selected_time_item.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/comment_input_componenet.dart';
import 'package:ish_top/ui/widgets/selectable_field.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/my_utils.dart';

class AnnFieldsThree extends StatefulWidget {
  const AnnFieldsThree({Key? key}) : super(key: key);

  @override
  State<AnnFieldsThree> createState() => _AnnFieldsThreeState();
}

class _AnnFieldsThreeState extends State<AnnFieldsThree> {
  final titleC = TextEditingController();
  final aimC = TextEditingController();
  final descC = TextEditingController();
  final fromC = TextEditingController();
  final toC = TextEditingController();

  final titleF = FocusNode();
  final aimF = FocusNode();
  final descF = FocusNode();
  final fromF = FocusNode();
  final toF = FocusNode();

  List<String> currencys = ["UZS", "USD", "RUB"];

  @override
  void initState() {
    titleC.text =
        BlocProvider.of<AnnouncementCubit>(context).state.fields["job_title"];
    aimC.text = BlocProvider.of<AnnouncementCubit>(context).state.fields["aim"];
    descC.text =
        BlocProvider.of<AnnouncementCubit>(context).state.fields["description"];
    String expectedSalary = BlocProvider.of<AnnouncementCubit>(context)
        .state
        .fields["expected_salary"];
    if (expectedSalary != "") {
      var splittedSalory = expectedSalary.split(" - ");
      fromC.text = splittedSalory[0];
      toC.text = splittedSalory[1];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          CommentInputComponent(
            height: 70,
            maxLength: 50,
            onSubmitted: (v) {
              MyUtils.fieldFocusChange(context, titleF, aimF);
            },
            hintText: "Job Title",
            onChanged: (text) {
              BlocProvider.of<AnnouncementCubit>(context)
                  .updateCurrentItem(fieldValue: text, fieldKey: "job_title");
            },
            commentFocusNode: titleF,
            textEditingController: titleC,
            textButton: IconButton(
              onPressed: () {
                titleC.clear();
              },
              icon: const Icon(Icons.clear, color: MyColors.C_356899),
            ),
          ),
          const SizedBox(height: 15),
          CommentInputComponent(
            height: 150,
            onSubmitted: (v) {
              MyUtils.fieldFocusChange(context, aimF, descF);
            },
            hintText: "Write your aim...",
            maxLength: 500,
            onChanged: (text) {
              BlocProvider.of<AnnouncementCubit>(context)
                  .updateCurrentItem(fieldValue: text, fieldKey: "aim");
            },
            commentFocusNode: aimF,
            textEditingController: aimC,
            textButton: IconButton(
              onPressed: () {
                aimC.clear();
              },
              icon: const Icon(Icons.clear, color: MyColors.C_356899),
            ),
          ),
          const SizedBox(height: 15),
          CommentInputComponent(
            height: 120,
            hintText: "Write description...",
            maxLength: 400,
            onSubmitted: (v) {
              descF.unfocus();
            },
            onChanged: (text) {
              BlocProvider.of<AnnouncementCubit>(context)
                  .updateCurrentItem(fieldValue: text, fieldKey: "description");
            },
            commentFocusNode: descF,
            textEditingController: descC,
            textButton: IconButton(
              onPressed: () {
                descC.clear();
              },
              icon: const Icon(Icons.clear, color: MyColors.C_356899),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Expected Salary:",
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("from"),
                    TextField(
                      controller: fromC,
                      focusNode: fromF,
                      onChanged: (value) {
                        context.read<AnnouncementCubit>().updateCurrentItem(
                            fieldValue: "${fromC.text} - ${toC.text}",
                            fieldKey: "expected_salary");
                      },
                      onSubmitted: (v) {
                        MyUtils.fieldFocusChange(context, fromF, toF);
                      },
                      cursorColor: MyColors.C_356899,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: MyColors.C_356899, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("to"),
                    TextField(
                      controller: toC,
                      focusNode: toF,
                      onChanged: (value) {
                        context.read<AnnouncementCubit>().updateCurrentItem(
                            fieldValue: "${fromC.text} - ${toC.text}",
                            fieldKey: "expected_salary");
                      },
                      onSubmitted: (v) {
                        toF.unfocus();
                      },
                      cursorColor: MyColors.C_356899,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: MyColors.C_356899, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SelectableField(
                currentValue: context
                    .read<AnnouncementCubit>()
                    .state
                    .fields['expected_salary_currency'],
                items: currencys,
                onChanged: (value) {
                  context.read<AnnouncementCubit>().updateCurrentItem(
                        fieldValue: currencys[value],
                        fieldKey: 'expected_salary_currency',
                      );
                  setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Time to Apply  : ",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectedTimeItem(
                  title: "From",
                  timeKey: "time_to_contact_from",
                  onTap: () async {
                    await selectTimeFrom(context: context, isFrom: true);
                    setState(() {});
                  }),
              SelectedTimeItem(
                title: "To",
                timeKey: "time_to_contact_to",
                onTap: () async {
                  await selectTimeFrom(context: context, isFrom: false);
                  setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
