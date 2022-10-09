import 'package:flutter/material.dart';
import 'package:ish_top/utils/style.dart';

class TopLeaderView extends StatelessWidget {
  const TopLeaderView({Key? key, required this.currentPage}) : super(key: key);

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getRoundedWidget(currentPage >= 1, "1"),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.grey,
            ),
          ),
          getRoundedWidget(currentPage >= 2, "2"),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.grey,
            ),
          ),
          getRoundedWidget(currentPage >= 3, "3"),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.grey,
            ),
          ),
          getRoundedWidget(currentPage >= 4, "4"),
        ],
      ),
    );
  }

  Widget getRoundedWidget(bool isActive, String text) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: isActive ? Color(0xff356899) : Color(0xff95969d),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: MyTextStyle.sfProBold.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
