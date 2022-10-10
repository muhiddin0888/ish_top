

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ish_top/data/models/category/category_item.dart';

class CategoryRepository{
  CategoryRepository({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;


  Future<void> postCategory({
    required CategoryItem categoryItem,
  }) async {
    try {
      var newCategory =
      await _fireStore.collection("categories").add(categoryItem.toJson());
      await _fireStore
          .collection("categories")
          .doc(newCategory.id)
          .update({"category_id": newCategory.id});
    } catch (e) {
      throw Exception();
    }
  }
}