class CvUrlModel {
  final String fileName;
  final String sizeOfFile;
  final String downloadUrl;

  CvUrlModel({
    required this.downloadUrl,
    required this.fileName,
    required this.sizeOfFile,
  });

  bool get isEmpty => fileName == "" && sizeOfFile == "" && downloadUrl == "";
}
