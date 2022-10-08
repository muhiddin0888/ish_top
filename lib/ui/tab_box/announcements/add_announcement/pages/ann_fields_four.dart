import 'package:flutter/material.dart';

class AnnFieldsFour extends StatefulWidget {
  const AnnFieldsFour({Key? key}) : super(key: key);

  @override
  State<AnnFieldsFour> createState() => _AnnFieldsFourState();
}

class _AnnFieldsFourState extends State<AnnFieldsFour> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(children: [
      Text("Pdg tanlaydi firebasedan url olib keladi "),
      Text("yerdan turib ishlashini tanlaydi masofadan ofisdan"),
    ],));
  }
}
