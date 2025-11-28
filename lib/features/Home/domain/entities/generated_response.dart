import 'package:indian_app_guy/features/Home/domain/entities/generated_data.dart';

class GeneratedResponse {
  bool? success;
  GeneratedData? data;
  String? message;

  GeneratedResponse({this.success, this.data, this.message});
}
