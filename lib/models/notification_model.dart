import 'package:intl/intl.dart';

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

  String get formattedDate {
    if (created == null || created!.isEmpty) return "";
    final DateTime dateTime = DateTime.parse(created!);
    return DateFormat('MMMM d').format(dateTime);
  }

  String get previewDate {
    if (created == null || created!.isEmpty) return "";
    final DateTime dateTime = DateTime.parse(created!);
    return DateFormat('MMMM d, y  |  h:mma').format(dateTime);
  }

  Map<String, dynamic> toJson() {
    return {
      "title" : title,
      "content" : content,
      "created" : created
    };
  }
}