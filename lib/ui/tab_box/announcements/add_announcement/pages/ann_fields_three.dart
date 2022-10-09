import 'package:flutter/material.dart';
import 'package:ish_top/ui/widgets/selectable_field.dart';

class AnnFieldsThree extends StatefulWidget {
  const AnnFieldsThree({Key? key}) : super(key: key);

  @override
  State<AnnFieldsThree> createState() => _AnnFieldsThreeState();
}

class _AnnFieldsThreeState extends State<AnnFieldsThree> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableField(
            items: ["SO'M", "USD", "RUR", "EUR", "LIRA", "WON", "TENGE"],
            onChanged: (value) {
              print(value);
            }),
        Text("Aim"),
        Text("Job Title"),
        Text("Description"),
        Text("Expected Salary"),
        Text("Time to contact"),
      ],
    );
  }
}
