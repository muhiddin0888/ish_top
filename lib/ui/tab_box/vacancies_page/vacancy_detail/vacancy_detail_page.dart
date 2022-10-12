import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ish_top/data/models/vacancy/vacancy_model.dart';
import 'package:ish_top/ui/tab_box/vacancies_page/vacancy_detail/widgets/desc_item.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:ish_top/ui/widgets/category_item_button.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/style.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class VacancyDetailPage extends StatefulWidget {
  const VacancyDetailPage(
      {Key? key, required this.vacancy, required this.index})
      : super(key: key);

  final VacancyModel vacancy;
  final int index;

  @override
  State<VacancyDetailPage> createState() => _VacancyDetailPageState();
}

class _VacancyDetailPageState extends State<VacancyDetailPage> {
  int selectedIndex = 0;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    var vac = widget.vacancy;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.38,
              width: double.infinity,
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Container(color: MyColors.C_356899),
                      Positioned(
                        left: 10,
                        top: 20,
                        child: IconButton(
                            style: IconButton.styleFrom(
                                foregroundColor: Colors.white),
                            iconSize: 24,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                                color: Colors.white, size: 24)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          width: 80,
                          height: 80,
                          child: Center(
                            child: Hero(
                              tag: "${widget.index}",
                              child: CachedNetworkImage(
                                imageUrl: vac.brandImage,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          vac.jobTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          vac.companyName,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CategoryItemButton(
                                onPressed: () {},
                                buttonText: "Detail",
                                buttonColor: Colors.white.withOpacity(0.2),
                                textColor: Colors.white,
                                fontSize: 11,
                              ),
                              CategoryItemButton(
                                onPressed: () {},
                                buttonText: vac.fromWhere == 0
                                    ? "Full-Time"
                                    : vac.fromWhere == 1
                                        ? "Part-Time"
                                        : "Any",
                                buttonColor: Colors.white.withOpacity(0.2),
                                textColor: Colors.white,
                                fontSize: 11,
                              ),
                              CategoryItemButton(
                                onPressed: () {},
                                buttonText: "Junior",
                                buttonColor: Colors.white.withOpacity(0.2),
                                textColor: Colors.white,
                                fontSize: 11,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.83,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                vac.offeredSalaryFrom,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  UrlLauncher.launchUrl(
                                      Uri.parse("tel:${vac.recruiterPhone}"));
                                },
                                child: Text(
                                  vac.recruiterPhone,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (index) {
                            return DescItem(
                              onPressed: () {
                                selectedIndex = index;
                                setState(() {});
                              },
                              text: (index == 0)
                                  ? "Description"
                                  : (index == 1)
                                      ? "Requirement"
                                      : (index == 2)
                                          ? "About"
                                          : "Reviews",
                              isSelected: selectedIndex == index,
                            );
                          },
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),
                    SliverToBoxAdapter(
                      child: Text(
                        'We are the teams who create all of Facebook\'s products '
                        'used by billions of people around the world. Want to build new '
                        'features and improve existing products like Messenger, Video, Groups, '
                        'News Feed, Search and more?',
                        style: MyTextStyle.sfProMedium
                            .copyWith(color: Colors.grey, height: 1.8),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: Text("Responsibilities",
                            style: MyTextStyle.sfProMedium),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        'Full stack web/mobile application development with '
                        'a variety of coding languages Create consumer products and'
                        ' features using internal programming language Hack Implement'
                        ' web or mobile interfaces using XHTML, CSS, and JavaScript',
                        style: MyTextStyle.sfProMedium.copyWith(color: Colors.grey, height: 1.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ActiveButton(
                buttonText: "Apply Now",
                onPressed: () {
                  UrlLauncher.launch("https://t.me/${vac.telegramUrl}", forceSafariVC: false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
