import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/app/app.dart';
import 'package:ish_top/cubits/announcement/announcement_cubit.dart';
import 'package:ish_top/cubits/helper/helper_cubit.dart';
import 'package:ish_top/cubits/user/user_cubit.dart';
import 'package:ish_top/cubits/vacancy/vacancy_cubit.dart';
import 'package:ish_top/data/repositories/announcement/announcement_repository.dart';
import 'package:ish_top/data/repositories/helper/helper_repository.dart';
import 'package:ish_top/data/repositories/user/user_repository.dart';
import 'package:ish_top/data/repositories/vacancy/vacancy_repository.dart';
import 'package:ish_top/theme.dart';
import 'package:ish_top/ui/login/login.dart';
import 'package:ish_top/ui/router.dart';
import 'package:ish_top/ui/tab_box/tab_box.dart';
import 'package:ish_top/utils/constants.dart';

class App extends StatelessWidget {
  App({super.key}) {
    _init();
  }

  late AuthenticationRepository authenticationRepository;

  void _init() async {
    authenticationRepository = AuthenticationRepository();
    await authenticationRepository.user.first;
  }

  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: authenticationRepository,
          ),
          RepositoryProvider(
            create: (_) => HelperRepository(fireStore: fireStore),
          ),
          RepositoryProvider(
            create: (_) => VacancyRepository(fireStore: fireStore),
          ),
          RepositoryProvider(
            create: (_) => AnnouncementRepository(fireStore: fireStore),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AppBloc(
                authenticationRepository:
                    context.read<AuthenticationRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => AnnouncementCubit(
                announcementRepository: context.read<AnnouncementRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => VacancyCubit(
                vacancyRepository: context.read<VacancyRepository>(),
                helperRepository: context.read<HelperRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => UserCubit(
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => HelperCubit(
                helperRepository: context.read<HelperRepository>(),
              ),
            ),
          ],
          child: AppView(),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      onGenerateRoute: MyRouter.generateRoute,
      initialRoute: splashPage,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (state.status == AppStatus.authenticated) {
        return TabBox();
      }
      return LoginPage();
    });
  }
}
