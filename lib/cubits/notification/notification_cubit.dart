import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ish_top/cubits/notification/notification_state.dart';
import 'package:ish_top/data/repositories/notification/notification_repostory.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({
    required this.notificationRepository,
  }) : super(NotificationInitial());

  final NotificationRepository notificationRepository;

  late StreamSubscription _subscription;

  Future<void> listenToVacancies() async {
    emit(GetNotificationProgress());
    _subscription = notificationRepository.getNews().listen(
      (items) {
        emit(GetNotificationInSuccess(news: items));
      },
      onError: (error) {
        emit(GetNotificationInFailure(errorText: error.toString()));
      },
    );
  }


  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
