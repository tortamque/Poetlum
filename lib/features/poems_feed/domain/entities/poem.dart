import 'package:equatable/equatable.dart';

class PoemEntity extends Equatable{
  const PoemEntity({this.author, this.title, this.lines, this.linecount});

  final String? author;
  final String? title;
  final List<String>? lines;
  final int? linecount;
  
  @override
  List<Object?> get props => [
    author,
    title,
    lines,
    linecount,
  ];
}
