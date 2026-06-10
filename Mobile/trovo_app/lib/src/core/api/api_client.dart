import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_exception.dart';
import 'api_config.dart';
import 'token_storage.dart';

class ApiClient {
  ApiClient({http.Client? httpClient, TokenStorage? tokenStorage})
    : _httpClient = httpClient ?? http.Client(),
      _tokenStorage = tokenStorage ?? TokenStorage();

  final http.Client _httpClient;
  final TokenStorage _tokenStorage;

  Future<Map<String, dynamic>> getJson(
    String path, {
    bool authenticated = false,
  }) async {
    final uri = _buildUri(path);
    final headers = await _buildHeaders(authenticated: authenticated);
    final response = await _httpClient.get(uri, headers: headers);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> postForm(
    String path, {
    required Map<String, String> fields,
    bool authenticated = false,
  }) async {
    final uri = _buildUri(path);
    final headers = await _buildHeaders(authenticated: authenticated);
    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    request.fields.addAll(fields);
    final streamed = await _httpClient.send(request);
    final response = await http.Response.fromStream(streamed);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> postJson(
    String path, {
    required Map<String, dynamic> body,
    bool authenticated = false,
  }) async {
    final uri = _buildUri(path);
    final headers = await _buildHeaders(authenticated: authenticated);
    headers['Content-Type'] = 'application/json';
    final response = await _httpClient.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Uri _buildUri(String path) {
    final cleanedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('${ApiConfig.baseUrl}$cleanedPath');
  }

  Future<Map<String, String>> _buildHeaders({
    required bool authenticated,
  }) async {
    final headers = <String, String>{'Accept': 'application/json'};
    if (authenticated) {
      final token = await _tokenStorage.readToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final status = response.statusCode;
    final body = response.body.isNotEmpty ? response.body : '{}';
    final decoded = jsonDecode(body);

    if (status < 200 || status >= 300) {
      final message = decoded is Map<String, dynamic>
          ? (decoded['message']?.toString() ?? 'Request failed')
          : 'Request failed';
      throw ApiException(
        message: message,
        statusCode: status,
        details: decoded,
      );
    }

    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    return {'data': decoded};
  }
}
