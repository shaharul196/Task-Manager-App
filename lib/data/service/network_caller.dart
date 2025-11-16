import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../../../app.dart';
import '../../ui/controllers/auth_controller.dart';
import '../../ui/screens/sign_in_screen.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? body;
  final String? errorMassage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMassage,
  });
}

class NetworkCaller {
  static const String _defaultErrorMassage = 'Something went wrong';
  static const String _unAuthorizeMassage = 'Un-authorize token';

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);

      final Map<String, String> headers = {
        'token': AuthController.accessToken ?? '',
      };

      _logRequest(url, null, headers);
      Response response = await get(uri, headers: headers);
      _logResponse(url, response);

      if (response.statusCode == 200) {
        // TODO sobcisu jsonEncode akare ase
        final decodedjson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedjson,
        );
      } else if (response.statusCode == 401) {
        _onUnAuthorize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMassage: _unAuthorizeMassage,
        );
      } else {
        final decodedjson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMassage: decodedjson['data'] ?? _defaultErrorMassage,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, String>? body, bool isFromLogin = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      final Map<String, String> headers = {
        'content-type': 'application/json',
        'token': AuthController.accessToken ?? '',
      };

      _logRequest(url, body, headers);
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response);

      if (response.statusCode == 200) {
        // TODO sobcisu jsonEncode akare ase
        final decodedjson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedjson,
        );
      } else if (response.statusCode == 401) {
        if(isFromLogin == false) {
          _onUnAuthorize();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMassage: _unAuthorizeMassage,
        );
      } else {
        final decodedjson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMassage: decodedjson['data'] ?? _defaultErrorMassage,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  static void _logRequest(
    String url,
    Map<String, String>? body,
    Map<String, String>? headers,
  ) {
    debugPrint(
      '==================Request================\n'
      'URL: $url\n'
      'HEADERS: $headers\n'
      'BODY: $body\n'
      '=================================',
    );
  }

  static void _logResponse(String url, Response response) {
    debugPrint(
      '=================Response=================\n'
      'URL: $url\n'
      'STATUS CODE: ${response.statusCode}\n'
      'BODY: ${response.body}\n'
      '=================================',
    );
  }

  static Future<void> _onUnAuthorize() async {
    await AuthController.clearData();
    Navigator.of(
      TaskManagerApp.navigator.currentContext!,
    ).pushNamedAndRemoveUntil(SignInScreen.name, (predicate) => false);
  }
}
