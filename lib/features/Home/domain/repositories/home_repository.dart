import 'package:fpdart/fpdart.dart';
import 'package:indian_app_guy/core/exceptions/failure.dart';
import 'package:indian_app_guy/features/Home/domain/entities/generated_response.dart';

abstract class HomeRepository {
  Future<Either<Failure, GeneratedResponse>> generatePPT(
    Map<String, dynamic> data,
  );
}
