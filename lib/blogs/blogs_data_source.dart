import '../base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadBlogs() {
    return BaseNetwork.get("blogs");
  }

  Future<Map<String, dynamic>> loadDetailBlogs(int idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("blogs/$id");
  }
}