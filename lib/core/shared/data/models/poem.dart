import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class PoemModel extends PoemEntity {
  const PoemModel({
    super.title = '',
    super.author = '',
    super.text = '',
    super.linecount = 0,
  });

  factory PoemModel.fromJson(Map<String, dynamic> json) => PoemModel(
    title: json['title'] ?? '',
    author: json['author'] ?? '',
    text: List<String>.from(json['lines'] ?? []).join('\n'),
    linecount: json['linecount'] != null ? int.parse(json['linecount'].toString()) : 0,
  );

  factory PoemModel.fromFirebase(Map<String, dynamic> json) => PoemModel(
    title: json['title'] ?? '',
    author: json['author'] ?? '',
    text: json['text'] ?? '',
    linecount: json['linecount'] != null ? int.parse(json['linecount'].toString()) : 0,
  );
}
