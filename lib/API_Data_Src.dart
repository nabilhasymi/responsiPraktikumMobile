import 'BaseNetwork.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> getCategories() {
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> getMeals(String QueryDiterima) {
    String Query = QueryDiterima;
    return BaseNetwork.get("filter.php?c=$Query");
  }

  Future<Map<String, dynamic>> detailsbook(String idDiterima) {
    String id = idDiterima;
    return BaseNetwork.get("lookup.php?i=$id");
  }
}
