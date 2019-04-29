
import 'dart:io';

import 'package:buddy_care/services/env-service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
export 'dart:convert';

const releaseHost = 'https://buddy-care.herokuapp.com/api/v1';
const stagingHost = 'https://buddy-care.herokuapp.com/api/v1';

class API {
  static String host;

  /// Basic **POST** request

  Future<Map<String, dynamic>> post({
      @required String url,
      Map<String, dynamic> headers,
      Map<String, dynamic> body: const {},
      bool debugLogBody: false,
    }) async {
      final resp = await _client.post(
        '$_host$url',
        body: json.encode(body),
        headers: headers,
      );
      _printRequestDetails(resp, debugLogBody);
      return _extractResponse(resp);
    }

  /// Basic **GET** request

  Future<Map<String, dynamic>> get({
    @required String url,
    Map<String, dynamic> headers,
    String params,
    debugLogBody: false,
    customHost: false,
  }) async {
    final String reqParams = params == null ? '' : '?$params';
    final String reqUrl = customHost ? '$url$reqParams' : '$_host$url$reqParams';

    final resp = await _client.get(
      reqUrl,
      headers: headers,
    );

    _printRequestDetails(resp, debugLogBody);
    return _extractResponse(resp);
  }

  /// Basic **PUT** request

  Future<Map<String, dynamic>> put({
    @required String url,
    Map<String, dynamic> headers,
    Map<String, dynamic> body: const {},
    bool debugLogBody: false,
  }) async {
    final resp = await _client.put(
      '$_host$url',
      body: json.encode(body),
      headers: headers,
    );
    _printRequestDetails(resp, debugLogBody);
    return _extractResponse(resp);
  }

  /// Basic **DELETE** request

  Future<Map<String, dynamic>> delete({
    @required String url,
    Map<String, dynamic> headers,
    bool debugLogBody: false,
  }) async {
    final resp = await _client.delete(
      '$_host$url',
      headers: headers,
    );
    _printRequestDetails(resp, debugLogBody);
    return _extractResponse(resp);
  }


  static final http.Client _client = http.Client();

  static get _host => EnvService.inRelease
    ? releaseHost
    : host ?? stagingHost;


  Map<String, String> get header => {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  Map<String, String> authHeader(accessToken) =>
    {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    };

  Map<String, Object> _extractResponse(http.Response response) {
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
