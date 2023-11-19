abstract class RemotePoemEvent{
  const RemotePoemEvent();
}

class GetInitialPoemsEvent extends RemotePoemEvent{
  const GetInitialPoemsEvent();
}

class GetPoemsEvent extends RemotePoemEvent{
  const GetPoemsEvent({
    required this.author,
    required this.title,
    required this.lineCount,
    required this.poemCount,
  });

  final String author;
  final String title;
  final String lineCount;
  final String poemCount;
}
