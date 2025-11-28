import 'package:indian_app_guy/features/Home/domain/entities/generated_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generated_data_model.g.dart';

@JsonSerializable()
class GeneratedDataModel {
  String? url;

  GeneratedDataModel({this.url});

  factory GeneratedDataModel.fromJson(Map<String, dynamic> json) =>
      _$GeneratedDataFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratedDataToJson(this);

  GeneratedData toEntity() => GeneratedData(url: url);
}
