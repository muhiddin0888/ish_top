import 'package:ish_top/data/models/job/job_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vacancy_model.g.dart';

@JsonSerializable()
class VacancyModel {
  @JsonKey(defaultValue: "", name: "vacancy_id")
  String vacancyId;

  @JsonKey(defaultValue: "", name: "company_name")
  String companyName;

  @JsonKey(defaultValue: "", name: "brand_image_url")
  String brandImage;

  @JsonKey(defaultValue: "", name: "category_id")
  String categoryId;

  @JsonKey(defaultValue: "", name: "user_id")
  String userId;

  @JsonKey(defaultValue: "", name: "created_at")
  String createdAt;

  @JsonKey(defaultValue: "", name: "job_title")
  String jobTitle;

  @JsonKey(defaultValue: "", name: "required_level")
  String requiredLevel;

  @JsonKey(defaultValue: "", name: "description")
  String description;

  @JsonKey(name: "job_type")
  JobType jobType;

  @JsonKey(defaultValue: "", name: "recruiter_phone")
  String recruiterPhone;

  @JsonKey(defaultValue: "", name: "telegram_url")
  String telegramUrl;

  @JsonKey(defaultValue: "", name: "offered_salary")
  String offeredSalary;

  @JsonKey(defaultValue: 0, name: "from_where")
  int fromWhere;

  VacancyModel({
    required this.vacancyId,
    required this.categoryId,
    required this.brandImage,
    required this.createdAt,
    required this.companyName,
    required this.description,
    required this.fromWhere,
    required this.jobTitle,
    required this.jobType,
    required this.offeredSalary,
    required this.recruiterPhone,
    required this.requiredLevel,
    required this.telegramUrl,
    required this.userId,
  });

  factory VacancyModel.fromJson(Map<String, dynamic> json) => _$VacancyModelFromJson(json);
  Map<String, dynamic> toJson() => _$VacancyModelToJson(this);
}