import 'package:json_annotation/json_annotation.dart';

part 'category_item.g.dart';

@JsonSerializable()
class CategoryItem {
  @JsonKey(defaultValue: "", name: "id")
  String categoryId;

  @JsonKey(defaultValue: "", name: "category_name")
  String categoryName;

  @JsonKey(defaultValue: "", name: "description")
  String description;

  @JsonKey(defaultValue: "", name: "created_at")
  String createdAt;

  @JsonKey(defaultValue: "", name: "icon")
  String icon;
  CategoryItem(
      {required this.categoryId,
      required this.categoryName,
      required this.createdAt,
      required this.description,
      required this.icon});

  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemToJson(this);
}
