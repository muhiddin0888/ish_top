import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ish_top/data/models/category/category_item.dart';

class HelperRepository {
  final FirebaseFirestore _fireStore;

  HelperRepository({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  Stream<List<CategoryItem>> getCategories() =>
      _fireStore.collection('categories').snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => CategoryItem.fromJson(doc.data()))
                .toList(),
          );

  Future<String> uploadCv(
    PlatformFile pickedFile,
  ) async {
    try {
      String storagePath = "files/pdf/${pickedFile.name}";
      var ref = FirebaseStorage.instance.ref().child(storagePath);
      var task = await ref.putFile(File(pickedFile.path!));
      String downloadUrl = await task.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      throw Exception();
    }
  }

  Future<bool> deleteCv({required String cvUrl}) async {
    try {
      String storagePath = "files/pdf/$cvUrl";
      FirebaseStorage.instance.ref().child(storagePath).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadUserImage(
    PlatformFile pickedFile,
  ) async {
    try {
      String storagePath = "files/images/${pickedFile.name}";
      var ref = FirebaseStorage.instance.ref().child(storagePath);
      var task = await ref.putFile(File(pickedFile.path!));
      String downloadUrl = await task.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      throw Exception();
    }
  }

  Future<PlatformFile?> selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      return result.files.first;
    } else {
      return null;
    }
  }
}
