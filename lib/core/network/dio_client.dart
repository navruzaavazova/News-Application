import 'package:dio/dio.dart';
import 'package:news_app/core/constants/app_string.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(BaseOptions(
          baseUrl: AppString.baseEndpoint,
        ));


  Future<Response?> getRequest(
      {required String endpoint, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to get request in DioClient: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
