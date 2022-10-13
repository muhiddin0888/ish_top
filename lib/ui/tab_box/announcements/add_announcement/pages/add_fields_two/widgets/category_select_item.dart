import 'package:flutter/material.dart';
import 'package:ish_top/data/models/category/category_item.dart';
import 'package:ish_top/utils/color.dart';

class CategorySelectItem extends StatelessWidget {
  CategorySelectItem({Key? key, required this.onTap, this.categoryItem})
      : super(key: key);

  final VoidCallback onTap;
  CategoryItem? categoryItem;

  @override
  Widget build(BuildContext context) {
    return categoryItem == null
        ? Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: MyColors.buttonColor,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: onTap,
              child: const Center(
                child: Text(
                  "Mutaxassislikni tanlash: 👨🏻‍💻",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        : Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: MyColors.white,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 16),
                  Image.network(
                    categoryItem!.icon,
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(
                          color: MyColors.buttonColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            categoryItem!.categoryName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          );
  }
}
