import 'package:flutter/material.dart';
import 'package:ish_top/utils/icon.dart';

import '../../../utils/style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/passive_button.dart';

class DetailAnnouncementsPage extends StatefulWidget {
  const DetailAnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<DetailAnnouncementsPage> createState() => _DetailAnnouncementsPageState();
}

class _DetailAnnouncementsPageState extends State<DetailAnnouncementsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Candidate Detail",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  child: Image.asset(
                    MyIcons.boardingImage1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Darlene Robertson",
                        style: MyTextStyle.sfBold800.copyWith(fontSize: 20),
                      ),
                      Text(
                        "Job: Senior Project Menger",
                        style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
                      ),
                      Text(
                        "Design Team",
                        style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            PassiveButton(
              buttonText: 'View Resume',
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Basic Information',
              style: MyTextStyle.sfBold800.copyWith(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Name"),
                Text(
                  "Darlene Robertson",
                  style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("age"),
                Text(
                  "37",
                  style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("level"),
                Text(
                  "level",
                  style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
                ),
              ],
            ), Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("telegramUrl"),
                Text(
                  "http/telegram url",
                  style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("timeToContact"),
                Text(
                  "08:00 - 22:00",
                  style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("jobTitle"),
                Text(
                  "Darlene Robertson",
                  style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("fromWhere"),
                Text(
                  "fromWhere",
                  style: MyTextStyle.sfProSemibold.copyWith(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              ElevatedButton(onPressed: (){}, child: Row(children: [Icon(Icons.phone),Text("Call Candidate",style: MyTextStyle.sfProBlack.copyWith(color: Colors.teal)),],)),
              ElevatedButton(onPressed: (){}, child: Row(children: [Icon(Icons.mail),Text("Message",style: MyTextStyle.sfProBlack.copyWith(color: Colors.teal))],))


            ],)


          ],
        ),
      ),
    );
  }
}
