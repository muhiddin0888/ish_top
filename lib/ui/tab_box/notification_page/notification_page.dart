import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ish_top/cubits/notification/notification_cubit.dart';
import 'package:ish_top/cubits/notification/notification_state.dart';
import 'package:ish_top/utils/style.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "News",
            style: MyTextStyle.sfProRegular.copyWith(fontSize: 24),
          ),
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
          if (state is GetNotificationProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetNotificationInFailure) {
            return Center(child: Text(state.errorText));
          } else if (state is GetNotificationInSuccess) {
            ListView(
              children: List.generate(state.news.length, (index) => ListTile()),
            );
          }
          return const SizedBox();
        }));
  }
}
