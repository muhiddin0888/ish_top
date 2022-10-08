// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacancy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacancyModel _$VacancyModelFromJson(Map<String, dynamic> json) => VacancyModel(
      vacancyId: json['vacancy_id'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      brandImage: json['brand_image_url'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      companyName: json['company_name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      fromWhere: json['from_where'] as int? ?? 0,
      jobTitle: json['job_title'] as String? ?? '',
      jobType: json['job_type'] as int? ?? 0,
      offeredSalary: json['offered_salary'] as String? ?? '',
      recruiterPhone: json['recruiter_phone'] as String? ?? '',
      requiredLevel: json['required_level'] as String? ?? '',
      telegramUrl: json['telegram_url'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
    );

Map<String, dynamic> _$VacancyModelToJson(VacancyModel instance) =>
    <String, dynamic>{
      'vacancy_id': instance.vacancyId,
      'company_name': instance.companyName,
      'brand_image_url': instance.brandImage,
      'category_id': instance.categoryId,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'job_title': instance.jobTitle,
      'required_level': instance.requiredLevel,
      'description': instance.description,
      'job_type': instance.jobType,
      'recruiter_phone': instance.recruiterPhone,
      'telegram_url': instance.telegramUrl,
      'offered_salary': instance.offeredSalary,
      'from_where': instance.fromWhere,
    };
