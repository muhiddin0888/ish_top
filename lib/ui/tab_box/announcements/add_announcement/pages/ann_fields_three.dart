import 'package:flutter/material.dart';
import 'package:ish_top/ui/tab_box/announcements/add_announcement/pages/widgets/comment_input_componenet.dart';
import 'package:ish_top/ui/widgets/selectable_field.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/my_utils.dart';

import 'widgets/clock.dart';

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

  TimeOfDay selectedTimeFrom = TimeOfDay.now();
  TimeOfDay selectedTimeTo = TimeOfDay.now();

  Future<TimeOfDay> _selectTimeFrom(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTimeFrom,
    );
    if (selected != null && selected != selectedTimeFrom) {
      setState(() {
        selectedTimeFrom = selected;
      });
    }
    return selectedTimeFrom;
  }

  Future<TimeOfDay> _selectTimeTo(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTimeTo,
    );
    if (selected != null && selected != selectedTimeTo) {
      setState(() {
        selectedTimeTo = selected;
      });
    }
    return selectedTimeTo;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
            onChanged: (text) {},
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
            onChanged: (text) {},
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
            onChanged: (text) {},
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Expected Salary:",
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
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
                items: const ["SO'M", "USD", "RUB"],
                onChanged: (value) {},
              ),
            ],
          ),

          ////         CLOCK  PART

          const SizedBox(height: 20),
          const Text(
            "Time to Apply  : ",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                child: SelectDateItem(
                  text: "${selectedTimeFrom.hour}:${selectedTimeFrom.minute}",
                  onTap: () async {
                    var t = await _selectTimeFrom(context);
                    setState(() {
                      selectedTimeFrom = t;
                    });
                  },
                ),
              ),
              Card(
                child: SelectDateItem(
                  text: "${selectedTimeTo.hour}:${selectedTimeFrom.minute}",
                  onTap: () async {
                    var t = await _selectTimeTo(context);
                    setState(() {
                      selectedTimeTo = t;
                    });
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
