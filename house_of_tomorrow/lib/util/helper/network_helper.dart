import 'dart:developer';

import 'package:dio/dio.dart';

abstract class NetworkHelper {
  static final Dio dio = Dio()
    ..interceptors.add( //..은 cascade Notation 문법 노션 참고
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 요청시
          log('REQ : [${options.method}] ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // 수신시
          log('RES : [${response.statusCode}] ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // 에러시
          log('ERR : [${e.response?.statusCode}] ${e.requestOptions.path}');
          return handler.next(e);
        },
      ),
    );
}
