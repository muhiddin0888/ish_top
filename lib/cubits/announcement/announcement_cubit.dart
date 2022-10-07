import 'package:bloc/bloc.dart';
import 'package:ish_top/data/repositories/announcement/announcement_repository.dart';
import 'package:ish_top/data/repositories/helper/helper_repository.dart';
import 'package:meta/meta.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit({
    required this.helperRepository,
    required this.announcementRepository,
  }) : super(AnnouncementInitial());

  final AnnouncementRepository announcementRepository;
  final HelperRepository helperRepository;
}
