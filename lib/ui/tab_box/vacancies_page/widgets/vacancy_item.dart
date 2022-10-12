import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ish_top/utils/icon.dart';

import '../../../../utils/color.dart';

class VacancyItem extends StatelessWidget {
  const VacancyItem({
    Key? key,
    required this.onTap,
    required this.brandImage,
    required this.companyName,
    required this.fromWhere,
    required this.jobTitle,
    required this.offeredSalary,
    required this.requiredLevel,
    required this.jobType,
    required this.recruiterPhone,
    required this.index,
  }) : super(key: key);
  final String brandImage;
  final String companyName;
  final String jobTitle;
  final String offeredSalary;
  final String requiredLevel;
  final int fromWhere;
  final int jobType;
  final String recruiterPhone;
  final VoidCallback onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: MyColors.C_5386E4,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(1, 3),
                blurRadius: 3,
                spreadRadius: 5,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: "$index",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: brandImage,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jobTitle,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: MyColors.white),
                    ),
                    Text(
                      companyName,
                      style: TextStyle(color: MyColors.C_E9E9EFF),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  MyIcons.status,
                  width: 25,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 25,
                  width: 20,
                  decoration: BoxDecoration(
                      color: MyColors.C_E9E9EFF,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(child: Text(jobType != 0 ? "IT" : "Desigin")),
                ),
                Container(
                  height: 25,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: MyColors.C_E9E9EFF,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(fromWhere == 0
                          ? "Full-Time"
                          : fromWhere == 1
                              ? "Part-Time"
                              : "any")),
                ),
                Container(
                  height: 25,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: MyColors.C_E9E9EFF,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(child: Text(requiredLevel)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  offeredSalary,
                  style: TextStyle(
                      color: MyColors.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  recruiterPhone,
                  style: TextStyle(color: MyColors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
