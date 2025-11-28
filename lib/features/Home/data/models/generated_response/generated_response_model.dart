import 'package:indian_app_guy/features/Home/data/models/generated_data/generated_data_model.dart';
import 'package:indian_app_guy/features/Home/domain/entities/generated_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated_response_model.g.dart';

@JsonSerializable()
class GeneratedResponseModel {
  bool? success;
  GeneratedDataModel? data;
  String? message;

  GeneratedResponseModel({this.success, this.data, this.message});

  factory GeneratedResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GeneratedResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratedResponseModelToJson(this);

  GeneratedResponse toEntity() => GeneratedResponse(
    success: success,
    data: data?.toEntity(),
    message: message,
  );
}
