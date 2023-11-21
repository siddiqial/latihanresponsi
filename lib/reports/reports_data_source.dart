import '../base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadReports() {
    return BaseNetwork.get("reports");
  }

  Future<Map<String, dynamic>> loadDetailReports(int idDiterima) {
    String id = idDiterima.toString();
    return BaseNetwork.get("reports/$id");
  }
}