import 'package:dio/dio.dart';
// import 'package:app/core/network/interceptors/retry_interceptor.dart';
import 'package:app/core/services/network_info_service.dart';
import 'package:app/core/utils/constants.dart';

class DioClient {
  late final Dio _dio;
  // ignore: unused_field
  final NetworkInfoService _networkInfo;

  DioClient({NetworkInfoService? networkInfo})
    : _networkInfo = networkInfo ?? NetworkInfoService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );

    // RetryInterceptor is commented out to disable the automatic retry system in the app.
    // _dio.interceptors.add(
    //   RetryInterceptor(dio: _dio, networkInfo: _networkInfo),
    // );
  }

  Dio get dio => _dio;

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }
}
