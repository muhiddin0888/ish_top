import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/cubits/helper/helper_cubit.dart';
import 'package:ish_top/data/models/category/category_item.dart';
import 'package:ish_top/ui/widgets/search_text_field.dart';
import 'package:ish_top/utils/my_utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<dynamic> selectCategoryBottomSheet(BuildContext context) {
  int element = -1;
  List<CategoryItem> searchedCategory = [];
  final TextEditingController searchController = TextEditingController();
  int selectedCategory = 0;
  int selectedCategoryForIcon = -1;
  
  return showBarModalBottomSheet(
    duration: const Duration(milliseconds: 650),
    isDismissible: false,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return BlocBuilder<HelperCubit, HelperState>(builder: (context, state) {
          if (state is GetCategoriesInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetCategoriesInSuccess) {

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: SvgPicture.asset("assets/svg/cancel.svg")),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          context
                              .read<AnnouncementCubit>().updateCurrentItem(fieldValue: state.categories[selectedCategory].categoryId, fieldKey: "category_id");

                          searchedCategory.isNotEmpty
                              ? MyUtils.getMyToast(
                                  message:
                                      "${state.categories[element].categoryName} muvaffaqiyatli tanlandi")
                              : MyUtils.getMyToast(
                                  message:
                                      "${state.categories[selectedCategory].categoryName} muvaffaqiyatli tanlandi");
                          Navigator.pop(context);
                          context
                                  .read<AnnouncementCubit>()
                                  .state
                                  .fields["category_id"] =
                              searchedCategory.isNotEmpty
                                  ? state.categories[element].categoryId
                                  :  state.categories[selectedCategory].categoryId;
                        },
                        child: Text("Bajarildi"))
                  ],
                ),
                SearchTextField(
                  controller: searchController,
                  onChanged: (value) => {
                    if (value.toString().isEmpty)
                      {
                        selectedCategory = -1,
                        element = -1,
                        selectedCategoryForIcon = -1,
                      },
                    searchedCategory = state.categories
                        .where(
                          (element) =>
                              element.categoryName.toLowerCase().contains(
                                    value.toString().toLowerCase(),
                                  ),
                        )
                        .toList(),
                    setState(
                      () => {},
                    ),
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchedCategory.isNotEmpty
                        ? searchedCategory.length
                        : state.categories.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => {
                        selectedCategory = index,
                        setState(
                          () => {
                            if (searchedCategory.isNotEmpty)
                              {
                                for (int i = 0;
                                    i < state.categories.length;
                                    i++)
                                  {
                                    if (state.categories[i].categoryName ==
                                        searchedCategory[selectedCategory]
                                            .categoryName)
                                      {
                                        element = i,
                                        selectedCategoryForIcon = index
                                      }
                                  },
                              },
                            context
                                .read<AnnouncementCubit>()
                                .state
                                .fields["category_id"] = selectedCategory,
                          },
                        ),
                      },
                      child: ListTile(
                        leading: SizedBox(
                          height: 70,
                          child: Image.network(
                            searchedCategory.isNotEmpty
                                ? searchedCategory[index].icon
                                : state.categories[index].icon,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(searchedCategory.isNotEmpty
                            ? searchedCategory[index].categoryName
                            : state.categories[index].categoryName),
                        subtitle: Text(searchedCategory.isNotEmpty
                            ? searchedCategory[index].description
                            : state.categories[index].description),
                        trailing: IconButton(
                          icon: searchedCategory.isNotEmpty
                              ? selectedCategoryForIcon == index
                                  ? const Icon(
                                      Icons.circle,
                                      color: Color(0xff356899),
                                    )
                                  : const Icon(
                                      Icons.circle_outlined,
                                      color: Color(0xff356899),
                                    )
                              : selectedCategory == index
                                  ? const Icon(
                                      Icons.circle,
                                      color: Color(0xff356899),
                                    )
                                  : const Icon(
                                      Icons.circle_outlined,
                                      color: Color(0xff356899),
                                    ),
                          onPressed: () => {
                            selectedCategory = index,
                            if (searchedCategory.isNotEmpty)
                              {
                                for (int i = 0;
                                    i < state.categories.length;
                                    i++)
                                  {
                                    if (state.categories[i].categoryName ==
                                        searchedCategory[selectedCategory]
                                            .categoryName)
                                      {
                                        element = i,
                                      }
                                  },
                              },
                            context
                                .read<AnnouncementCubit>().updateCurrentItem(fieldValue: state.categories[selectedCategory].categoryId, fieldKey: "category_id"),
                            setState(() => {}),

                          },
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            );
          } else if (state is GetCategoriesInFailure) {
            return Text(state.errorText);
          } else {
            return const SizedBox();
          }
        });
      },
    ),
  );
}
