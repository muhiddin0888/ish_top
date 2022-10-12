import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ish_top/data/models/announcement/announcement_model.dart';
import 'package:ish_top/data/models/vacancy/vacancy_model.dart';

class VacancyRepository {
  final FirebaseFirestore _fireStore;

  VacancyRepository({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  Future<void> postVacancy({
    required Map<String , dynamic> json,
  }) async {
    try {
      var newVacancy =
          await _fireStore.collection("vacancies").add(json);
      await _fireStore
          .collection("vacancies")
          .doc(newVacancy.id)
          .update({"vacancy_id": newVacancy.id});
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> updateVacancy({
    required VacancyModel vacancyModel,
    required String docId,
  }) async {
    try {
      await _fireStore
          .collection("vacancies")
          .doc(docId)
          .update(vacancyModel.toJson());
    } catch (e) {
      throw Exception();
    }
  }

  Stream<List<VacancyModel>> getVacancies() =>
      _fireStore.collection('vacancies').snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => VacancyModel.fromJson(doc.data()))
                .toList(),
          );

  Stream<List<VacancyModel>> getVacanciesByCategory({required String categoryId}) =>
      _fireStore
          .collection('vacancies')
          .where("category_id", isEqualTo: categoryId)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
            .map((doc) => VacancyModel.fromJson(doc.data()))
            .toList(),
      );

  Future<void> deleteVacancy({
    required String docId,
  }) async {
    try {
      await _fireStore.collection("vacancies").doc(docId).delete();
    } catch (e) {
      throw Exception();
    }
  }
}
