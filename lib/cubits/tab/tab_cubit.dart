import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(TabHome());
  int tabIndex = 0;

  void changeTabState(int currentIndex) {
    if (currentIndex == 0) {
      tabIndex = 0;
      emit(TabHome());
    } else if (currentIndex == 1) {
      tabIndex = 1;
      emit(TabCategory());
    } else if (currentIndex == 2) {
      tabIndex = 2;
      emit(TabCard());
    }
  }
}
