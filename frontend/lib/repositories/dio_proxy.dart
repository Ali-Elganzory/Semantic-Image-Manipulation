import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/repositories/api_url.dart';

import '/third_party/third_party.dart';
import '/exceptions/exceptions.dart';

class DioProxy {
  final Dio dio = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 60000),
    ),
  );

  Future<Response> post({
    required String url,
    String? base,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    bool isMultipart = false,
  }) async {
    if (base != null) {
      dio.options.baseUrl = base;
    } else {
      dio.options.baseUrl = ApiUrl.base;
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (!isMultipart) 'Connection': 'keep-alive',
      if (!isMultipart) "Keep-Alive": "timeout=5, max=1000",
      if (token != null) 'access-token': token
    };

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }

    debugPrint('URL => ${dio.options.baseUrl + url}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    return await request(
      () async => await dio.post(
        url,
        data: data,
        queryParameters: query,
        onSendProgress: progressCallback,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response> get({
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    bool isMultipart = false,
  }) async {
    dio.options.baseUrl = ApiUrl.base;

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (!isMultipart) 'Connection': 'keep-alive',
      if (!isMultipart) "Keep-Alive": "timeout=5, max=1000",
      if (token != null) 'access_token': token
    };

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }

    debugPrint('URL => ${dio.options.baseUrl + url}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    return await request(
      () async => await dio.get(
        url,
        queryParameters: query,
        cancelToken: cancelToken,
      ),
    );
  }
}

extension on DioProxy {
  Future request(Future<Response> Function() request) async {
    try {
      final r = await request.call();
      debugPrint("Response => ${r.data}");
      return r;
    } on DioError catch (e) {
      debugPrint("Error Message => ${e.message}");

      if (e.response != null) {
        debugPrint("Error Response => ${e.response}");
        debugPrint("Error Response Status Code => ${e.response!.statusCode}");
        debugPrint("Error Response Data => ${e.response!.data}");

        if (e.response!.data is Map &&
            e.response!.data.toString().isNotEmpty &&
            e.response!.data['result']['message'] != null) {
          debugPrint(
              "Error Response Data Message => ${e.response!.data['result']['message']}");
        }

        throw Failure(
          e.response!.data is Map && e.response!.data.toString().isNotEmpty
              ? e.response!.data['result']['message'] ??
                  e.response!.statusMessage
              : e.response!.data,
        );
      } else {
        throw Failure(
          e.message ?? 'Something went wrong',
        );
      }
    }
  }
}
