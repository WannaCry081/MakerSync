class NotificationModel {
  final int? id;
  final String? created;
  final String title;
  final String content;

  const NotificationModel({
    this.id,
    this.created,
    required this.title,
    required this.content,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] as int? ?? 0,
      created: json["created"] as String? ?? "",
      title: json["title"] as String? ?? "",
      content: json["content"] as String? ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title" : title,
      "content" : content,
      "created" : created
    };
  }
}