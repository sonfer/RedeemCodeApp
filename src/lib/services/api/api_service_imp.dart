import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../../shared/constants.dart';
import '../../utils/app_exception.dart';
import 'api_service.dart';
import 'package:http/http.dart' as http;

class ApiServiceImp extends ApiService {
  final String _baseUrl = Constants.baseUrl;
  int timeout = 10;
  Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String url, {String token = ""}) async {
    var responseJson;
    try {
      if (token != null && token.isNotEmpty)
        _headers["Authorization"] = 'Bearer $token';
      final response = await http
          .get(Uri.parse(_baseUrl + url), headers: _headers)
          .timeout(const Duration(seconds: 10));

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(Constants.networkErrorMessage);
    } on TimeoutException catch (e) {
      throw FetchDataException(Constants.timeoutMessage + " $e");
    } on Error catch (e) {
      throw FetchDataException(Constants.unexpectedErrorMessage + " $e");
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body, {String token = ""}) async {
    var responseJson;
    try {
      if (token != null && token.isNotEmpty)
        _headers["Authorization"] = 'Bearer $token';
      final response = await http
          .post(Uri.parse(_baseUrl + url),
              body: body.toJson(),
              encoding: Encoding.getByName("utf-8"),
              headers: _headers)
          .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(Constants.networkErrorMessage);
    } on TimeoutException catch (e) {
      print(e.toString());
      throw FetchDataException(Constants.timeoutMessage);
    } on Error catch (e) {
      print(e.toString());
      throw FetchDataException(Constants.unexpectedErrorMessage);
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body, {String token = ""}) async {
    var responseJson;
    try {
      if (token != null && token.isNotEmpty)
        _headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      final response = await http.put(Uri.parse(_baseUrl + url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(Constants.networkErrorMessage);
    } on TimeoutException catch (e) {
      throw FetchDataException(Constants.timeoutMessage + " $e");
    } on Error catch (e) {
      throw FetchDataException(Constants.unexpectedErrorMessage + " $e");
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, {String token = ""}) async {
    var apiResponse;
    try {
      if (token != null && token.isNotEmpty)
        _headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      final response = await http.delete(Uri.parse(_baseUrl + url));
      apiResponse = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(Constants.networkErrorMessage);
    } on TimeoutException catch (e) {
      throw FetchDataException(Constants.timeoutMessage + " $e");
    } on Error catch (e) {
      throw FetchDataException(Constants.unexpectedErrorMessage + " $e");
    }
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 400:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    // case 400:
    //   throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
