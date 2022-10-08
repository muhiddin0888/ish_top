import 'package:flutter/material.dart';

class AnnFieldsThree extends StatefulWidget {
  const AnnFieldsThree({Key? key}) : super(key: key);

  @override
  State<AnnFieldsThree> createState() => _AnnFieldsThreeState();
}

class _AnnFieldsThreeState extends State<AnnFieldsThree> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(children: [
      Text("Aim"),
      Text("Job Title"),
      Text("Description"),
      Text("Expected Salary"),
      Text("Time to contact"),
    ],));
  }
}
