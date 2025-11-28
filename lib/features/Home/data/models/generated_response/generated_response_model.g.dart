// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratedResponseModel _$GeneratedResponseModelFromJson(
  Map<String, dynamic> json,
) => GeneratedResponseModel(
  success: json['success'] as bool?,
  data:
      json['data'] == null
          ? null
          : GeneratedDataModel.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$GeneratedResponseModelToJson(
  GeneratedResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'message': instance.message,
};
