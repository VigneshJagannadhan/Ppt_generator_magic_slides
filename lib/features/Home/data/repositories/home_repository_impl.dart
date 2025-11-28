import 'package:fpdart/fpdart.dart';
import 'package:indian_app_guy/core/exceptions/failure.dart';
import 'package:indian_app_guy/features/Home/data/data_sources/home_data_source.dart';
import 'package:indian_app_guy/features/Home/domain/entities/generated_response.dart';
import 'package:indian_app_guy/features/Home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeDataSource dataSource;

  HomeRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, GeneratedResponse>> generatePPT(
    Map<String, dynamic> data,
  ) async {
    var result = await dataSource.generatePPT(data);
    return result.map((response) => response.toEntity());
  }
}
