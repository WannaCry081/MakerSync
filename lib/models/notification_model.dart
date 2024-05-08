class NotificationModel {
  final String title;
  final String content;

  const NotificationModel({
    required this.title,
    required this.content,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json["title"] as String? ?? "",
      content: json["content"] as String? ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title" : title,
      "content" : content
    };
  }
}