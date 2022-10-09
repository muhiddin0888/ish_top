import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/helper/helper_cubit.dart';
import 'package:ish_top/utils/color.dart';
import 'package:ish_top/utils/constants.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
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
                Navigator.pushNamed(context, addAnnouncementPage);
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
    );
  }
}
