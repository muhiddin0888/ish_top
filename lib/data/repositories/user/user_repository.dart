import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ish_top/data/models/announcement/announcement_model.dart';
import 'package:ish_top/data/models/users/user_model.dart';

class UserRepository {
  final FirebaseFirestore _fireStore;

  UserRepository({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  Future<void> postUser({
    required UserModel userModel,
  }) async {
    try {
      await _fireStore.collection("users").doc(userModel.userId).set(
            userModel.toJson(),
          );
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> updateUser({
    required UserModel userModel,
  }) async {
    try {
      await _fireStore
          .collection("users")
          .doc(userModel.userId)
          .update(userModel.toJson());
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> deleteUser({
    required String docId,
  }) async {
    try {
      await _fireStore.collection("users").doc(docId).delete();
    } catch (e) {
      throw Exception();
    }
  }
}
