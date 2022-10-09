import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/app/app.dart';
import 'package:ish_top/ui/widgets/active_button.dart';
import 'package:ish_top/ui/widgets/category_item_button.dart';
import 'package:ish_top/ui/widgets/search_text_field.dart';
import 'package:ish_top/ui/widgets/selectable_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ProfilePage());

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isActive = false;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      body: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(user.email!),
              Text(user.id.toString()),
              TextButton(
                onPressed: () {},
                child: const Icon(Icons.edit),
              ),
              ActiveButton(
                buttonText: 'Next',
                width: 158,
                onPressed: () {},
              ),
              const SizedBox(height: 15),
              SearchTextField(controller: TextEditingController()),
              const SizedBox(height: 15),
              Row(
                children: [
                  CategoryItemButton(
                    buttonText: 'All',
                    onPressed: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                    isActive: isActive,
                  ),
                  const SizedBox(width: 16),
                  CategoryItemButton(
                    icon: const FlutterLogo(),
                    buttonText: 'Flutter',
                    onPressed: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                    isActive: !isActive,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
              ...List.generate(
                3,
                (index) => SelectableButton(
                  onPressed: () {
                    selectedIndex = index;
                    setState(() {});
                  },
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  isActive: selectedIndex == index,
                  icon: const Icon(Icons.access_time_rounded, color: Colors.black),
                  text: (index == 0) ? 'Full Time' : (index == 1) ? 'Part Time' : 'Any',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
