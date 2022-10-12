import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/helper/helper_cubit.dart';
import 'package:ish_top/ui/tab_box/announcements/widgets/custom_drawer.dart';
import 'package:ish_top/data/models/announcement/announcement_model.dart';
import 'package:ish_top/data/models/users/user_model.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/constants.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  final args = AnnouncementModel(
      currency: "USD",
      address: 'Tashkent/Chirchiq',
      age: 19,
      aim:
          """Ex labore officia ad velit nostrud proident. Occaecat qui ullamco incididunt culpa ut officia velit ad duis proident anim esse ipsum. Excepteur cillum ipsum do aliqua aute anim sint pariatur eu commodo enim. Tempor dolor enim nulla fugiat aliqua quis nulla adipisicing. Ipsum culpa qui excepteur labore voluptate in Lorem adipisicing proident deserunt ad ea dolor.""",
      announcementId: 'qwerty12345',
      categoryId: 'bir narsa',
      createdAt: DateTime.now().toString(),
      cvUrl: '',
      description: """
Ex labore officia ad velit nostrud proident. Occaecat qui ullamco incididunt culpa ut officia velit ad duis proident anim esse ipsum. Excepteur cillum ipsum do aliqua aute anim sint pariatur eu commodo enim. Tempor dolor enim nulla fugiat aliqua quis nulla adipisicing. Ipsum culpa qui excepteur labore voluptate in Lorem adipisicing proident deserunt ad ea dolor.
 excepteur mollit. Proident do exercitation nostrud incididunt adipisicing irure cillum culpa in mollit magna irure. Laborum aliquip consectetur proident consequat aliquip veniam pariatur sint officia. Ea fugiat ut eu consequat esse esse cillum excepteur nostrud velit quis aliquip officia. Ex laboris officia nostrud et cillum dolore cupidatat id aliquip id laboris irure.
""",
      expectedSalary: '\$500',
      fromWhere: 2,
      fullName: 'YorqinBek Yuldashev',
      isValid: true,
      jobTitle: 'Flutter Mobile Developer',
      jobType: 1,
      knowledge: """
Lorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
when an unknown printer took a galley of type and scrambled it to make a type
specimen book.
It has survived not only five centuries,
 but also the leap into electronic typesetting,
""",
      level: 'Junior',
      phoneNumber: '+998999955876',
      telegramUrl: '@yorqinbek_yuldashev',
      timeToContactTo: '9:00 - 21:00',
      timeToContactFrom: '9:00 - 21:00',

      userId: 'qwerty3003');
  final List<UserModel> users = [
    UserModel(
      imageUrl:
          "https://toppng.com//public/uploads/preview/lionel-messi-11562889923r8pkpoknqh.png",
      createdAt: DateTime.now(),
      fullName: "Messi",
      phoneNumber: "+998999955876",
      userId: "qwerty1234",
    ),
    UserModel(
      imageUrl: "https://cdn-icons-png.flaticon.com/512/805/805401.png",
      createdAt: DateTime.now(),
      fullName: "Cristiono Ronaldo",
      phoneNumber: "+9989991344234",
      userId: "qwerty3003",
    ),
    UserModel(
      imageUrl:
          "https://toppng.com/uploads/preview/neymar-11548370598bjgcfe316v.png",
      createdAt: DateTime.now(),
      fullName: "Neymar",
      phoneNumber: "+998994123804",
      userId: "qwerty4321",
    ),
    UserModel(
      imageUrl:
          "https://i.pinimg.com/originals/12/d4/dc/12d4dc3380789ec851ad4815beaec1a8.png",
      createdAt: DateTime.now(),
      fullName: "Mbappe",
      phoneNumber: "+1233213213",
      userId: "qwerty8888",
    )
  ];
  @override
  void initState() {
    BlocProvider.of<HelperCubit>(context).listenToCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: const Text("E'lonlar!"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  detailAnnouncements,
                  arguments: [args, users],
                ); //detail Announcementga shuyerdan o'tib turdim
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<HelperCubit, HelperState>(
        builder: (context, state) {
          if (state is GetCategoriesInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetCategoriesInSuccess) {
            return ListView(
              children: List.generate(
                  state.categories.length,
                  (index) => ListTile(
                        title: Text(state.categories[index].categoryName),
                      )),
            );
          }
          return Text("error");
        },
      ),
      drawer: const CustomDrawer(),
    );
  }
}
