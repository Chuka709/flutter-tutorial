import 'package:dio/dio.dart';

class CustomInterceptors extends InterceptorsWrapper {
  CustomInterceptors()
      : super(
          onRequest: (option, handler) {
            print('On request');
            return handler.next(option);
          },
          onResponse: (response, handler) {
            print('On response');
            return handler.next(response);
          },
          onError: (DioException e, handler) {
            print('On error');
            return handler.next(e);
          },
        );
}
