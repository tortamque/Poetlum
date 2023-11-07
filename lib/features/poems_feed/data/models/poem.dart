import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class PoemModel extends PoemEntity{
  const PoemModel({
    String? title,
    String? author,
    List<String>? lines,
    int? linecount,
  });

  factory PoemModel.fromJson(Map<String, dynamic> json) => PoemModel(
    title: json['title'] ?? '',
    author: json['author'] ?? '',
    lines: json['lines'] ?? [],
    linecount: json['linecount'] != null ? int.parse(json['linecount']) : 0,
  );
}
