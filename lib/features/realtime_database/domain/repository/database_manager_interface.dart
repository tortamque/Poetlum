abstract class IDatabaseManager{
  void write(Map data, String path);
  Future<Map?> read(String path);
}
