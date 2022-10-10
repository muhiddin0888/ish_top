import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ish_top/data/api_services/custom_exceptions.dart';
import 'package:ish_top/utils/constants.dart';

class MapApiClient {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: mapBaseUrl,
      connectTimeout: 25000,
      receiveTimeout: 20000,
    ),
  );

  MapApiClient() {
    _init();
  }

  Future _init() async {
    dio.interceptors.add(
      (InterceptorsWrapper(
        onError: (error, handler) async {
          debugPrint("ON ERRORGA KIRDI");
          switch (error.type) {
            case DioErrorType.connectTimeout:
            case DioErrorType.sendTimeout:
            case DioErrorType.receiveTimeout:
              throw DeadlineExceededException(error.requestOptions);
            case DioErrorType.response:
              switch (error.response?.statusCode) {
                case 400:
                  throw BadRequestException(error.response?.data['message']);
                case 401:
                  throw UnauthorizedException(error.requestOptions);
                case 404:
                  throw NotFoundException(error.requestOptions);
                case 409:
                  throw ConflictException(error.requestOptions);
                case 500:
                  throw InternalServerErrorException(error.requestOptions);
              }
              break;
            case DioErrorType.cancel:
              break;
            case DioErrorType.other:
              throw NoInternetConnectionException(error.requestOptions);
          }
          debugPrint('Error Status Code:${error.response?.statusCode}');
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) {
          debugPrint("ON REQUESTGA KIRDI");
          requestOptions.headers["Accept"] = "application/json";
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("ON RESPONSEGA KIRDI");
          return handler.next(response);
        },
      )),
    );
  }
}