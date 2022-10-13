import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ish_top/data/models/notification/news_model.dart';

class NotificationRepository {
  final FirebaseFirestore _fireStore;

  NotificationRepository({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  Stream<List<CachedNews>> getNews() =>
      _fireStore.collection('vacancies').snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => CachedNews.fromJson(doc.data()))
                .toList(),
          );
}
