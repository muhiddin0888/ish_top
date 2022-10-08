import 'package:flutter/material.dart';

class AnnFieldsTwo extends StatefulWidget {
  const AnnFieldsTwo({Key? key}) : super(key: key);

  @override
  State<AnnFieldsTwo> createState() => _AnnFieldsTwoState();
}

class _AnnFieldsTwoState extends State<AnnFieldsTwo> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Text("Level"),
        Text("Knowledge"),
        Text("Category"),
        Text("Job Type"),
      ],
    ));
  }
}
