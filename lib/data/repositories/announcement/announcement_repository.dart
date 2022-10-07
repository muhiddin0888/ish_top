import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ish_top/data/models/announcement/announcement_model.dart';

class AnnouncementRepository {
  final FirebaseFirestore _fireStore;

  AnnouncementRepository({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  Future<void> postAnnouncement({
    required AnnouncementModel announcementModel,
  }) async {
    try {
      var newAnnouncement = await _fireStore
          .collection("announcements")
          .add(announcementModel.toJson());
      await _fireStore
          .collection("announcements")
          .doc(newAnnouncement.id)
          .update({"announcement_id": newAnnouncement.id});
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> updateAnnouncement({
    required AnnouncementModel announcementModel,
    required String docId,
  }) async {
    try {
      await _fireStore
          .collection("announcements")
          .doc(docId)
          .update(announcementModel.toJson());
    } catch (e) {
      throw Exception();
    }
  }

  Stream<List<AnnouncementModel>> getAnnouncements() =>
      _fireStore.collection('announcements').snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => AnnouncementModel.fromJson(doc.data()))
                .toList(),
          );

  Stream<List<AnnouncementModel>> getAnnouncementsByCategory(
          {required String categoryId}) =>
      _fireStore
          .collection('announcements')
          .where("category_id", isEqualTo: categoryId)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => AnnouncementModel.fromJson(doc.data()))
                .toList(),
          );

  Future<void> deleteAnnouncement({
    required String docId,
  }) async {
    try {
      await _fireStore.collection("announcements").doc(docId).delete();
    } catch (e) {
      throw Exception();
    }
  }
}
