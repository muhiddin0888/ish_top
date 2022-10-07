class JobType {
  final String id;
  final String name;

  JobType({
    required this.id,
    required this.name,
  });

  factory JobType.fromJson(Map<String, Object?> json) {
    return JobType(
      id: json["id"] as String? ?? "",
      name: json["name"] as String? ?? "",
    );
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name
    };
  }
}
