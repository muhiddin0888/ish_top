import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/helper/helper_cubit.dart';
import 'package:ish_top/cubits/vacancy/vacancy_cubit.dart';
import 'package:ish_top/ui/tab_box/vacancies_page/vacancy_detail/vacancy_detail_page.dart';
import 'package:ish_top/ui/tab_box/vacancies_page/widgets/vacancy_item.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/icon.dart';
import 'package:ish_top/utils/style.dart';


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
    return Scaffold(
      appBar: AppBar(
        title: Text("Applications",
            style: MyTextStyle.sfProSemibold.copyWith(fontSize: 20)),
        centerTitle: true,
        actions: [ClipOval(child: Image.asset(MyIcons.boardingImage1))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("You have\n27 Applications 👍",
                style: MyTextStyle.sfBold800.copyWith(fontSize: 25)),
            const SizedBox(height: 10),
            BlocBuilder<HelperCubit, HelperState>(
              builder: (context, state) {
                if (state is GetCategoriesInProgress) {
                  return const CircularProgressIndicator();
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
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.C_CACBCE),
                          child: const Center(child: Text("all")),
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
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.C_CACBCE),
                            child: Center(
                              child: Row(
                                children: [
                                  Image.network(state.categories[index].icon,
                                      fit: BoxFit.scaleDown),
                                  Text(state.categories[index].categoryName),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  );
                } else if (state is GetCategoriesInFailure) {
                  return Text(state.errorText);
                } else {
                  return const SizedBox();
                }
              },
            ),
            BlocBuilder<VacancyCubit, VacancyState>(
              builder: (context, state) {
                if (state is GetVacancyProgress) {
                  return const CircularProgressIndicator();
                } else if (state is GetVacancyInFailure) {
                  return Center(child: Text(state.errorText));
                } else if (state is GetVacancyInSuccess) {
                  return Expanded(
                    child: ListView(
                      children: List.generate(state.vacancies.length, (index) {
                        return VacancyItem(
                          index: index,
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(seconds: 1),
                                reverseTransitionDuration: const Duration(seconds: 1),
                                pageBuilder: (c, a, sA) {
                                  return FadeTransition(opacity: a, child: VacancyDetailPage(vacancy: state.vacancies[index], index: index));
                                },
                              ),
                            );
                          },
                          brandImage: state.vacancies[index].brandImage,
                          companyName: state.vacancies[index].companyName,
                          fromWhere: state.vacancies[index].fromWhere,
                          jobTitle: state.vacancies[index].jobTitle,
                          offeredSalary: state.vacancies[index].offeredSalaryFrom,
                          requiredLevel: state.vacancies[index].requiredLevel,
                          recruiterPhone: state.vacancies[index].recruiterPhone,
                          jobType: state.vacancies[index].jobType,
                        );
                      }),
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
