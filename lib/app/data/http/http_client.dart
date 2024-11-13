import 'dart:convert';  // Para utilizar jsonEncode
import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String url});
  Future<http.Response> post({required String url, Map<String, dynamic>? body});
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }
  
  @override
  Future<http.Response> post({required String url, Map<String, dynamic>? body}) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body != null ? jsonEncode(body) : null,
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao fazer requisição POST: $e');
    }
  }
}
