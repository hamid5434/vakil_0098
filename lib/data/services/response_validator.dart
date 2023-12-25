import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vakil_0098/common/exceptions.dart';

mixin ResponseValidator {
  validateResponse(http.StreamedResponse response) async {

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final respStr = await response.stream.bytesToString();
      try {
        final result = json.decode(
            (respStr != 'success') ? respStr : '{"status" : "success"}');
        //print('result $result , $body');
        return result;
      } catch (ex) {
        return respStr;
      }
    } else if (response.statusCode == 400) {
      final respStr = await response.stream.bytesToString();
      print(respStr.toString());
      try {
        final result = json.decode(
            (respStr != 'success') ? respStr : '{"status" : "success"}');
        var errors = result['errors'][''][0];
        print(result);
        return AppException(
          message: errors,
          statusCode: response.statusCode,
        );
      } catch (e) {
        return AppException(
          message: respStr.toString(),
          statusCode: response.statusCode,
        );
      }
    } else if (response.statusCode == 401) {
      return AppException(
        message: 'نام کاربری یا رمز عبور اشتباه است' + ' - ' + response.statusCode.toString(),
        statusCode: response.statusCode,
      );
    }
    else if (response.statusCode == 403) {
      return AppException(
        message: 'شما دسترسی به این ماژول را ندارید.' + ' - ' + response.statusCode.toString(),
        statusCode: response.statusCode,
      );
    }
    else if (response.statusCode == 404) {
      return AppException(
        message: ' Not Found' + ' - ' + response.statusCode.toString(),
        statusCode: response.statusCode,
      );
    } else {
      final respStr = await response.stream.bytesToString();
      final result = json
          .decode((respStr != 'success') ? respStr : '{"status" : "success"}');
      return AppException(
        message: response.reasonPhrase.toString(),
        statusCode: response.statusCode,
      );
    }
  }

  validateResponseByStatusCode(http.StreamedResponse response) async {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else if (response.statusCode >= 400) {
      final respStr = await response.stream.bytesToString();
      try {
        final result = json.decode(
            (respStr != 'success') ? respStr : '{"status" : "success"}');
        var errors = result['errors'][''][0];
        print(result);
        return AppException(
          message: errors,
          statusCode: response.statusCode,
        );
      } catch (e) {
        return AppException(
          message: respStr.toString(),
          statusCode: response.statusCode,
        );
      }
    } else if (response.statusCode == 401) {
      return AppException(
        message: 'نام کاربری یا رمز عبور اشتباه است' + ' - ' + response.statusCode.toString(),
        statusCode: response.statusCode,
      );
    }
    else if (response.statusCode == 403) {
      return AppException(
        message: 'شما دسترسی به این ماژول را ندارید.' + ' - ' + response.statusCode.toString(),
        statusCode: response.statusCode,
      );
    }
    else if (response.statusCode == 404) {
      return AppException(
        message: ' Not Found' + ' - ' + response.statusCode.toString(),
        statusCode: response.statusCode,
      );
    } else {
      final respStr = await response.stream.bytesToString();
      final result = json
          .decode((respStr != 'success') ? respStr : '{"status" : "success"}');
      return AppException(
        message: response.reasonPhrase.toString(),
        statusCode: response.statusCode,
      );
    }
  }

}
