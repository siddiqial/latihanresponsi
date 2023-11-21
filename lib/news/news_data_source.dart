import '../base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadNews() {
    return BaseNetwork.get("articles");
  }

  Future<Map<String, dynamic>> loadDetailNews(int idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("articles/$id");
  }
}