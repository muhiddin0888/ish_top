import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:formz/formz.dart';
import 'package:ish_top/data/models/cv_url/cv_url_model.dart';
import 'package:ish_top/data/repositories/helper/helper_repository.dart';

part 'cv_url_state.dart';

class CvUrlCubit extends Cubit<CvUrlState> {
  CvUrlCubit({required HelperRepository helperRepository})
      : _helperRepository = helperRepository,
        super(
          CvUrlState(
            cvUrl: CvUrlModel(
              downloadUrl: "",
              fileName: "",
              sizeOfFile: "",
            ),
          ),
        );

  final HelperRepository _helperRepository;

  Future<void> selectAndUploadCv() async {
    PlatformFile? pickedFile = await _helperRepository.selectFile();
    if (pickedFile == null) {
      emit(
        state.copyWith(
          errorText: "File not picked",
          status: FormzStatus.submissionFailure,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormzStatus.submissionInProgress,
          cvUrl: CvUrlModel(
            downloadUrl: "",
            fileName: "onProgress",
            sizeOfFile: "onProgress",
          ),
        ),
      );
      String downloadUrl = await _helperRepository.uploadCv(pickedFile);
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          cvUrl: CvUrlModel(
            downloadUrl: downloadUrl,
            fileName: pickedFile.name,
            sizeOfFile: "${(pickedFile.size / 1000000).toStringAsFixed(1)} mb",
          ),
        ),
      );
    }
  }

  Future<void> deleteCv() async {
    await _helperRepository.deleteCv(
      cvUrl: state.cvUrl.fileName,
    );
    emit(
      state.copyWith(
        status: FormzStatus.submissionSuccess,
        cvUrl: CvUrlModel(
          downloadUrl: "",
          fileName: "",
          sizeOfFile: "",
        ),
      ),
    );
  }
}