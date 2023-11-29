import 'package:equatable/equatable.dart';

class PoemEntity extends Equatable{
  const PoemEntity({this.author, this.title, this.text, this.linecount});

  final String? author;
  final String? title;
  final String? text;
  final int? linecount;
  
  @override
  List<Object?> get props => [
    author,
    title,
    text,
    linecount,
  ];

  Map<String, dynamic> toJson() => {
      'title': title,
      'author': author,
      'text': text,
      'linecount': linecount,
    };
}
