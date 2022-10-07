class UserModel {
  final String userId;
  final String fullName;
  final String phoneNumber;
  final String imageUrl;
  final DateTime createdAt;

  UserModel({
    required this.imageUrl,
    required this.createdAt,
    required this.fullName,
    required this.phoneNumber,
    required this.userId,
  });

  factory UserModel.fromJson(Map<String, Object?> json) {
    return UserModel(
      userId: json["user_id"] as String? ?? "",
      fullName: json["full_name"] as String? ?? "",
      phoneNumber: json["phone_number"] as String? ?? "",
      createdAt: DateTime.parse(json["created_at"] as String? ?? ""),
      imageUrl: json["image_url"] as String? ?? "",
    );
  }

  Map<String, Object> toJson() {
    return {
      "user_id": userId,
      "full_name": fullName,
      "phone_number": phoneNumber,
      "created_at": createdAt.toString(),
      "image_url": imageUrl,
    };
  }
}
