import 'dart:async';

import 'package:flutter/material.dart';

import '/third_party/third_party.dart';
import '/exceptions/exceptions.dart';
import '/repository/api_url.dart';

class DioProxy {
  final Dio dio = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 60000),
      baseUrl: ApiUrl.base,
      followRedirects: true,
    ),
  );

  Future<Response> get({
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    bool isMultipart = false,
  }) async {
    dio.options.headers = getHeaders(isMultipart);

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

  Future<Response> post({
    required String url,
    String? base,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    bool isMultipart = false,
    bool isFile = false,
  }) async {
    if (isFile) {
      dio.options.headers = null;
    } else {
      dio.options.headers = getHeaders();
    }

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

  Future<Response> put({
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

    dio.options.headers = getHeaders(isMultipart);

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }

    debugPrint('URL => ${dio.options.baseUrl + url}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    return await request(
      () async => await dio.put(
        url,
        data: data,
        queryParameters: query,
        onSendProgress: progressCallback,
        cancelToken: cancelToken,
      ),
    );
  }
}

Map<String, String> getHeaders([bool isFile = false]) => {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
      "Keep-Alive": "timeout=5, max=1000",
    };

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
