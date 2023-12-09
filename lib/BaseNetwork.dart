import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static final String baseURL = "https://www.themealdb.com/api/json/v1/1/";

  static Future<Map<String, dynamic>> get(String partURL) async {
    final String fullURL = baseURL + partURL;

    debugPrint("BaseNetwork - fullURL : $fullURL");

    final response = await http.get(Uri.parse(fullURL));

    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
      http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      print("processResponse error");
      return {"error": true};
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}
