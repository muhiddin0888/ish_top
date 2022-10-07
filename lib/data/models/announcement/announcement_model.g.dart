// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementModel _$AnnouncementModelFromJson(Map<String, dynamic> json) =>
    AnnouncementModel(
      jobType: JobType.fromJson(json['job_type'] as Map<String, dynamic>),
      userId: json['user_id'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      address: json['address'] as String? ?? '',
      aim: json['aim'] as String? ?? '',
      announcementId: json['announcement_id'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      cvUrl: json['cv_url'] as String? ?? '',
      expectedSalary: json['expected_salary'] as String? ?? '',
      fromWhere: json['from_where'] as int? ?? 0,
      jobTitle: json['job_title'] as String? ?? '',
      knowledge: json['knowledge'] as String? ?? '',
      level: json['level'] as String? ?? '',
      telegramUrl: json['telegram_url'] as String? ?? '',
      timeToContact: json['time_to_contact'] as String? ?? '',
    );

Map<String, dynamic> _$AnnouncementModelToJson(AnnouncementModel instance) =>
    <String, dynamic>{
      'announcement_id': instance.announcementId,
      'full_name': instance.fullName,
      'age': instance.age,
      'phone_number': instance.phoneNumber,
      'telegram_url': instance.telegramUrl,
      'knowledge': instance.knowledge,
      'level': instance.level,
      'address': instance.address,
      'aim': instance.aim,
      'created_at': instance.createdAt,
      'category_id': instance.categoryId,
      'user_id': instance.userId,
      'job_title': instance.jobTitle,
      'description': instance.description,
      'job_type': instance.jobType,
      'expected_salary': instance.expectedSalary,
      'time_to_contact': instance.timeToContact,
      'cv_url': instance.cvUrl,
      'from_where': instance.fromWhere,
    };
