import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ish_top/data/models/category/category_item.dart';
import 'package:ish_top/data/repositories/helper/helper_repository.dart';
import 'package:meta/meta.dart';

part 'helper_state.dart';

class HelperCubit extends Cubit<HelperState> {
  HelperCubit({
    required this.helperRepository,
  }) : super(HelperInitial());

  final HelperRepository helperRepository;

  late StreamSubscription _subscription;

  Future<void> listenToCategories() async {
    emit(GetCategoriesInProgress());
    _subscription = helperRepository.getCategories().listen(
      (items) {
        emit(GetCategoriesInSuccess(categories: items));
      },
      onError: (error) {
        emit(GetCategoriesInFailure(errorText: error.toString()));
      },
    );
  }





 
  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
