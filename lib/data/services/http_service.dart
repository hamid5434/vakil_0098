import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../common/common.dart';
import '../../common/exceptions.dart';
import '../../common/token/Token.dart';
import 'response_validator.dart';

abstract class IHttpServices {
  Future<dynamic> post({required String url, var body, bool? hasClientType});

  Future<dynamic> requestStatusCodeByMethod(
      {required String url, var body, bool? hasClientType, String method});

  Future<dynamic> postWithOutToken({required String url, var body});

  Future<dynamic> get({required String url});

  Future<dynamic> put({required String url, var body});

  Future<dynamic> delete({required String url, var body});
}

class HttpServices with ResponseValidator implements IHttpServices {
  @override
  Future delete({required String url, body}) async {
    try {
      var userToken = Token.appAuthModel!;
      String? token = userToken.accessToken;
      print(token);

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      if (token == null) {
        headers = {'Content-Type': 'application/json'};
      }

      var request = http.Request('DELETE', Uri.parse(url));
      String bodyStr = json.encode(body);
      String bodyStrFatoEn = Common.StrConvertNumE2P(bodyStr);

      print(url);
      print(bodyStrFatoEn);

      request.body = bodyStrFatoEn;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var result = await validateResponseByStatusCode(response);
      if (result is AppException) {
        if (result.statusCode == 401) {
          //showDialog();
        }
        throw result;
      } else {
        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future get({required String url}) async {
    try {
      var userToken = Token.appAuthModel!;
      String? token = userToken.accessToken;
      print(token);
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      if (token == null) {
        headers = {'Content-Type': 'application/json'};
      }

      var request = http.Request('GET', Uri.parse(url));

      print(url);

      // if (url.contains('sap.okcs.com')) {
      request.headers.addAll(headers);
      //}

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      var result = await validateResponse(response);

      if (result is AppException) {
        if (result.statusCode == 401) {
          //showDialog();
        }
        throw result;
      } else {
        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future post({required String url, body, bool? hasClientType}) async {
    try {
      var userToken = Token.appAuthModel!;
      String? token = userToken.accessToken;
      print(token);
      print(body.toString());

      var headers;

      if (hasClientType != null && hasClientType) {
        headers = headers = {
          'X-AppType': '2',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        };
      } else {
        headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        };
      }
      // var headers = {
      //   'Authorization': 'Bearer $token',
      //   'Content-Type': 'application/json'
      // };

      if (token == null) {
        headers = {'Content-Type': 'application/json'};
      }

      var request = http.Request('POST', Uri.parse(url));
      String bodyStr = json.encode(body);
      String bodyStrFatoEn = Common.StrConvertNumE2P(bodyStr);

      print(url);
      print(bodyStrFatoEn);

      request.body = bodyStrFatoEn;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var result = await validateResponse(response);
      if (result is AppException) {
        if (result.statusCode == 401) {
          //showDialog();
        }
        throw result;
      } else {
        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future postWithOutToken({required String url, body}) async {
    try {
      var headers = {'Content-Type': 'application/json'};

      var request = http.Request('POST', Uri.parse(url));
      String bodyStr = json.encode(body);
      String bodyStrFatoEn = Common.StrConvertNumE2P(bodyStr);

      print(url);
      print(bodyStrFatoEn);

      request.body = bodyStrFatoEn;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var result = await validateResponse(response);

      if (result is AppException) {
        if (result.statusCode == 401) {
         // showDialog();
        }
        throw result;
      } else {
        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future put({required String url, body}) async {
    try {
      var userToken = Token.appAuthModel!;
      String? token = userToken.accessToken;
      print(token);
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      if (token == null) {
        headers = {'Content-Type': 'application/json'};
      }

      var request = http.Request('PUT', Uri.parse(url));
      String bodyStr = json.encode(body);
      String bodyStrFatoEn = Common.StrConvertNumE2P(bodyStr);

      print(url);
      print(bodyStrFatoEn);

      request.body = bodyStrFatoEn;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var result = await validateResponse(response);

      if (result is AppException) {
        throw result;
      } else {
        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future requestStatusCodeByMethod(
      {required String url,
      body,
      bool? hasClientType,
      String method = 'POST'}) async {
    try {
      var userToken = Token.appAuthModel!;
      String? token = userToken.accessToken;
      print(token);

      Map<String, String> headers;
      if (hasClientType != null && hasClientType) {
        headers = {
          'X-AppType': '2',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        };
      } else {
        headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        };
      }
      // var headers = clientType
      //     ? {
      //         'X-AppType': '2',
      //         'Authorization': 'Bearer $token',
      //         'Content-Type': 'application/json'
      //       }
      //     : {
      //         'Authorization': 'Bearer $token',
      //         'Content-Type': 'application/json'
      //       };

      if (token == null) {
        headers = {'Content-Type': 'application/json'};
      }

      var request = http.Request(method, Uri.parse(url));
      String bodyStr = json.encode(body);
      String bodyStrFatoEn = Common.StrConvertNumE2P(bodyStr);

      print(url);
      print(bodyStrFatoEn);

      request.body = bodyStrFatoEn;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var result = await validateResponseByStatusCode(response);

      if (result is AppException) {
        if (result.statusCode == 401) {
        //  showDialog();
        }
        throw result;
      } else {
        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  // showDialog() {
  //
  //   //Common.singInDilog();
  // }
}
