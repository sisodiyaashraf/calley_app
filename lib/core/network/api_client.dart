import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'api_exception.dart';

/// Lightweight HTTP client wrapper for executing requests with JSON payloads.
class ApiClient {
  const ApiClient(this._client);

  final http.Client _client;

  /// Executes a GET request with JSON body and query parameters.
  Future<dynamic> getWithBody(
    String path, {
    Map<String, String>? query,
    Map<String, dynamic>? body,
  }) async {
    try {
      final fullPath = path.startsWith('http') ? path : '${ApiConfig.baseUrl}$path';
      final baseUri = Uri.parse(fullPath);
      final uri = query != null && query.isNotEmpty
          ? baseUri.replace(queryParameters: {...baseUri.queryParameters, ...query})
          : baseUri;

      final request = http.Request('GET', uri);
      request.headers['Content-Type'] = 'application/json';
      if (body != null) {
        request.body = jsonEncode(body);
      }

      final streamedResponse = await _client.send(request).timeout(ApiConfig.timeout);
      final response = await http.Response.fromStream(streamedResponse).timeout(ApiConfig.timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      } else {
        throw AppException.fromStatus(response.statusCode);
      }
    } on TimeoutException {
      throw const AppException('Request timed out');
    } on SocketException {
      throw const AppException('No internet connection');
    } on http.ClientException {
      throw const AppException('No internet connection');
    } on AppException {
      rethrow;
    } catch (_) {
      throw const AppException('Something went wrong');
    }
  }
}
