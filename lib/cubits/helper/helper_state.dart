part of 'helper_cubit.dart';

@immutable
abstract class HelperState {}

class HelperInitial extends HelperState {}

//-----------GetCategoriesInProgress------------
class GetCategoriesInProgress extends HelperState {}

class GetCategoriesInSuccess extends HelperState {
  GetCategoriesInSuccess({required this.categories});

  final List<CategoryItem> categories;
}

class GetCategoriesInFailure extends HelperState {
  final String errorText;
  GetCategoriesInFailure({required this.errorText});
}
