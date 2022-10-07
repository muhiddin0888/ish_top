import 'package:ish_top/data/models/job/job_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'announcement_model.g.dart';

@JsonSerializable()
class AnnouncementModel {
  @JsonKey(defaultValue: "", name: "announcement_id")
  String announcementId;

  @JsonKey(defaultValue: "", name: "full_name")
  String fullName;

  @JsonKey(defaultValue: 0, name: "age")
  int age;

  @JsonKey(defaultValue: "", name: "phone_number")
  String phoneNumber;

  @JsonKey(defaultValue: "", name: "telegram_url")
  String telegramUrl;

  @JsonKey(defaultValue: "", name: "knowledge")
  String knowledge;

  @JsonKey(defaultValue: "", name: "level")
  String level;

  @JsonKey(defaultValue: "", name: "address")
  String address;

  @JsonKey(defaultValue: "", name: "aim")
  String aim;

  @JsonKey(defaultValue: "", name: "created_at")
  String createdAt;

  @JsonKey(defaultValue: "", name: "category_id")
  String categoryId;

  @JsonKey(defaultValue: "", name: "user_id")
  String userId;

  @JsonKey(defaultValue: "", name: "job_title")
  String jobTitle;

  @JsonKey(defaultValue: "", name: "description")
  String description;

  @JsonKey(name: "job_type")
  JobType jobType;

  @JsonKey(defaultValue: "", name: "expected_salary")
  String expectedSalary;

  @JsonKey(defaultValue: "", name: "time_to_contact")
  String timeToContact;

  @JsonKey(defaultValue: "", name: "cv_url")
  String cvUrl;

  @JsonKey(defaultValue: 0, name: "from_where")
  int fromWhere;

  AnnouncementModel({
    required this.jobType,
    required this.userId,
    required this.createdAt,
    required this.phoneNumber,
    required this.fullName,
    required this.age,
    required this.description,
    required this.address,
    required this.aim,
    required this.announcementId,
    required this.categoryId,
    required this.cvUrl,
    required this.expectedSalary,
    required this.fromWhere,
    required this.jobTitle,
    required this.knowledge,
    required this.level,
    required this.telegramUrl,
    required this.timeToContact,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementModelToJson(this);
}
