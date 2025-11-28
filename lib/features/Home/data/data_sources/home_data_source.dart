import 'package:fpdart/fpdart.dart';
import 'package:indian_app_guy/core/constants/app_urls.dart';
import 'package:indian_app_guy/core/exceptions/failure.dart';
import 'package:indian_app_guy/core/services/api_service.dart';
import 'package:indian_app_guy/features/Home/data/models/generated_response/generated_response_model.dart';

abstract class HomeDataSource {
  Future<Either<Failure, GeneratedResponseModel>> generatePPT(
    Map<String, dynamic> data,
  );
}

class HomeDataSourceImpl extends HomeDataSource {
  ApiService apiService;

  HomeDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, GeneratedResponseModel>> generatePPT(
    Map<String, dynamic> data,
  ) async {
    var result = await apiService.post(route: AppUrls.generatePPT, data: data);
    return result.map(
      (response) => GeneratedResponseModel.fromJson(response.data),
    );
  }
}
