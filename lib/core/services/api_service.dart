import 'package:dio/dio.dart';
import 'package:indian_app_guy/core/constants/app_urls.dart';
import 'package:indian_app_guy/core/exceptions/failure.dart';
import 'package:fpdart/fpdart.dart';

class ApiService {
  late Dio _dio;
  Dio get dio => _dio;

  ApiService() {
    _dio = Dio(BaseOptions(baseUrl: AppUrls.baseUrl));

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }

  Future<Either<Failure, Response>> get({
    required String route,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      Response response = await _dio.get(
        route,
        queryParameters: query,
        data: data,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(convertError(e));
    } catch (_) {
      return Left(Failure(message: "Something went wrong!"));
    }
  }

  Future<Either<Failure, Response>> post({
    required String route,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      Response response = await _dio.post(
        route,
        queryParameters: query,
        data: data,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(convertError(e));
    } catch (_) {
      return Left(Failure(message: "Something went wrong!"));
    }
  }

  Failure convertError(DioException e) {
    if (e.response != null) {
      try {
        return Failure(
          message:
              e.response?.data["message"]?.toString() ?? "Something went wrong",
          statusCode: e.response?.statusCode,
        );
      } catch (e) {
        return Failure(message: "Something went wrong");
      }
    }

    return Failure(message: "Network error. Please try again");
  }
}
