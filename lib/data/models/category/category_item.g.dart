// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItem _$CategoryItemFromJson(Map<String, dynamic> json) => CategoryItem(
      categoryId: json['id'] as String? ?? '',
      categoryName: json['category_name'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );

Map<String, dynamic> _$CategoryItemToJson(CategoryItem instance) =>
    <String, dynamic>{
      'id': instance.categoryId,
      'category_name': instance.categoryName,
      'description': instance.description,
      'created_at': instance.createdAt,
      'icon': instance.icon,
    };
