import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileImageShimmer extends StatelessWidget {
  const ProfileImageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle
        ),
        child: const ClipOval(child: SizedBox()),
      ),
    );
  }
}