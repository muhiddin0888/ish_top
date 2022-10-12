import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/helper/helper_cubit.dart';
import 'package:ish_top/cubits/vacancy/vacancy_cubit.dart';
import 'package:ish_top/ui/widgets/vacancies_card.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';
import 'package:ish_top/utils/style.dart';

import '../../widgets/category_item_button.dart';

class VacanciesPage extends StatefulWidget {
  const VacanciesPage({Key? key}) : super(key: key);

  @override
  State<VacanciesPage> createState() => _VacanciesPageState();
}

class _VacanciesPageState extends State<VacanciesPage> {
  @override
  void initState() {
    BlocProvider.of<HelperCubit>(context).listenToCategories();
    BlocProvider.of<VacancyCubit>(context).listenToVacancies();
    super.initState();
  }

  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Applications",
          style: MyTextStyle.sfProSemibold.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          ClipOval(
            child: Image.asset(MyIcons.boardingImage1),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You have\n27 Applications 👍",
              style: MyTextStyle.sfBold800.copyWith(fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<HelperCubit, HelperState>(
              builder: (context, state) {
                if (state is GetCategoriesInProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is GetCategoriesInSuccess) {
                  return SizedBox(
                    height: 40,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<VacancyCubit>(context)
                              .listenToVacancies();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.C_CACBCE,
                          ),
                          child: const Center(
                            child: Text(
                              "All",
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(
                        state.categories.length,
                        (index) => GestureDetector(
                          onTap: () {
                            BlocProvider.of<VacancyCubit>(context)
                                .listenToVacanciesById(
                                    categoryId:
                                        state.categories[index].categoryId);
                          },
                          child: Padding(

                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CategoryItemButton(
                              isActive: isActive,
                              buttonText: state.categories[index].categoryName,
                              onPressed: () {
                               BlocProvider.of<VacancyCubit>(context)
                                .listenToVacanciesById(
                                    categoryId:
                                        state.categories[index].categoryId);
                              },
                              icon: Image.network(state.categories[index].icon),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  );
                } else if (state is GetCategoriesInFailure) {
                  return Text(state.errorText);
                } else {
                  return SizedBox();
                }
              },
            ),
            SizedBox(height: height * .01),
            BlocBuilder<VacancyCubit, VacancyState>(
              builder: (context, state) {
                if (state is GetVacancyProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetVacancyInFailure) {
                  return Center(
                    child: Text(state.errorText),
                  );
                } else if (state is GetVacancyInSuccess) {
                  return Expanded(
                    child: ListView(
                      children: List.generate(
                          state.vacancies.length,
                          (index) => VacanciesCard(
                              width: width,
                              height: height,
                              logoPath:
                                  state.vacancies[index].brandImage.toString(),
                              jobTitle:
                                  state.vacancies[index].jobTitle.toString(),
                              salary: state.vacancies[index].offeredSalary
                                  .toString(),
                              compName:
                                  state.vacancies[index].companyName.toString(),
                              location:
                                  state.vacancies[index].fromWhere.toString(),
                              status: state.vacancies[index].requiredLevel
                                  .toString(),
                              time:
                                  state.vacancies[index].createdAt.toString())),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}