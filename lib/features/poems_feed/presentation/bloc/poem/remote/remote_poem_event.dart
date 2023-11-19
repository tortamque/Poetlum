abstract class RemotePoemEvent{
  const RemotePoemEvent();
}

class GetInitialPoemsEvent extends RemotePoemEvent{
  const GetInitialPoemsEvent();
}

class GetPoemsEvent extends RemotePoemEvent{
  const GetPoemsEvent({
    this.author,
    this.title,
    this.lineCount,
    this.poemCount,
  });

  final String? author;
  final String? title;
  final String? lineCount;
  final String? poemCount;
}
