import 'package:flutter/material.dart';
import 'package:ish_top/utils/color.dart';

class VacanciesCard extends StatelessWidget {
  const VacanciesCard({
    Key? key,
    required this.width,
    required this.height,
    required this.logoPath,
    required this.jobTitle,
    required this.salary,
    required this.compName,
    required this.location,
    required this.status,
    required this.time,
  }) : super(key: key);

  final double width;
  final double height;
  final String logoPath;
  final String jobTitle;
  final String salary;
  final String compName;
  final String location;
  final String status;
  final String time;

  @override
  Widget build(BuildContext context) {
    checkStatus() {
      if (status == 'Junior' || status == 'junior') {
        return Colors.red;
      } else if (status == 'Middle' || status == 'middle') {
        return Colors.green;
      } else if (status == 'Senior' || status == 'senior') {
        return Colors.blue;
      } else {
        return Colors.white;
      }
    }

    checkBackground() {
      if (status == 'Junior' || status == 'junior') {
        return const Color(0xFFFFEDED);
      } else if (status == 'Middle' || status == 'middle') {
        return const Color(0xFFE8FDF2);
      } else if (status == 'Senior' || status == 'senior') {
        return const Color(0xFFEDF3FC);
      } else {
        return Colors.black;
      }
    }

    checkLocation(){
      if (location == '0'){
        return 'Uydan';
      } else if (location == '1') {
        return  'Ishxonadan';
      } else if (location == '2') {
        return  'Gibrid';
      } else {
        return 'Noaniq';
      }
    }

    return Container(
      width: width * 1,
      height: height * .2,
      margin: EdgeInsets.fromLTRB(width * .04, height * .03, width * .04, 0),
      decoration: BoxDecoration(
          color: MyColors.backgroundColor, borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        Expanded(
            child: Row(
          children: [
            SizedBox(width: width * .04),
            Image.network(
              logoPath,
              width: width * .13,
              height: height * .13,
            ),
            Padding(
              padding: EdgeInsets.only(top: height * .02, left: width * .03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobTitle,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        compName,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$$salary/m',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(checkLocation(),
                          style: const TextStyle(color: Colors.blueGrey))
                    ],
                  ),
                ],
              ),
            )
          ],
        )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * .29,
                height: height * .045,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: checkBackground()),
                child: Center(
                    child: Text(
                  status,
                  style: TextStyle(
                      color: checkStatus(), fontWeight: FontWeight.w600),
                )),
              ),
              Text(
                time,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          ),
        ))
      ]),
    );
  }
}
