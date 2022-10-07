import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/app/app.dart';
import 'package:ish_top/theme.dart';
import 'package:ish_top/ui/home/home.dart';
import 'package:ish_top/ui/login/login.dart';
import 'package:ish_top/ui/router.dart';
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
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: authenticationRepository,
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
        return HomePage();
      }
      return LoginPage();
    });
  }
}
