import 'package:buddy_care/services/env-service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

export 'dart:convert';

const releaseHost = 'https://google.com';
const stagingHost = 'https://google.com';

class API {
  static String host;

  /// Basic **POST** request
  static Future<Map<String, Object>> post({
    @required String url,
    Map<String, dynamic> body: const {},
    bool debugLogBody: false,
  }) async {
    final resp = await _client.post(
      '$_host$url',
      body: json.encode(body),
      headers: _headers,
    );
    _printRequestDetails(resp, debugLogBody);
    return _extractResponse(resp);
  }

  /// Basic **GET** request
  ///
  /// [customHost] - set to `true` if you need to make call with different host (e.g. for Firebase requests) and provide full [url]
  ///
  /// [debugLogBody] - set `true` to see response body in debug console
  ///
  /// [params] - get params, omit the first **'?' sign** since it already presents
  static Future<Map<String, Object>> get({
    @required String url,
    String params,
    debugLogBody: false,
    customHost: false,
  }) async {
    final String reqParams = params == null ? '' : '?$params';
    final String reqUrl = customHost ? '$url$reqParams' : '$_host$url$reqParams';

    final resp = await _client.get(
      reqUrl,
      headers: _headers,
    );

    _printRequestDetails(resp, debugLogBody);
    return _extractResponse(resp);
  }

  static const _ctHeader = {
    'Content-Type': 'application/json',
  };

  static final http.Client _client = http.Client();

  static get _host => EnvService.inRelease
    ? releaseHost
    : host ?? stagingHost;

  static Map<String, String> get _headers => _ctHeader;

  static Map<String, Object> _extractResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
        break;
      case 400:
      case 401:
      case 404:
        print('Server error \n code: ${response.statusCode}, body: ${response.body}');
        throw new Exception(response.body);
        break;
      default:
        throw new Exception('Failed to perform a request, status: ${response.statusCode}');
        break;
    }
  }

  static void _printRequestDetails(http.Response response, bool debugLogBody) {
    print('Request to - ${response.request.url}');
    print('Resp status - ${response.statusCode}');
    if (debugLogBody) {
      print('Resp body - ${response.body}');
    }
  }
}
