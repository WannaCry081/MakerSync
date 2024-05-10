class NotificationModel {
  final String? id;
  final String? date;
  final String title;
  final String content;

  const NotificationModel({
    this.id,
    this.date,
    required this.title,
    required this.content,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] as String? ?? "",
      date: json["date"] as String? ?? "",
      title: json["title"] as String? ?? "",
      content: json["content"] as String? ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title" : title,
      "content" : content,
      "date" : date
    };
  }
}