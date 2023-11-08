import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class PoemModel extends PoemEntity {
  const PoemModel({
    super.title = '',
    super.author = '',
    super.lines = const [],
    super.linecount = 0,
  });

  factory PoemModel.fromJson(Map<String, dynamic> json) => PoemModel(
    title: json['title'] ?? '',
    author: json['author'] ?? '',
    lines: List<String>.from(json['lines'] ?? []),
    linecount: json['linecount'] != null ? int.parse(json['linecount'].toString()) : 0,
  );
}
