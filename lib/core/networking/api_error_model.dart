import 'package:json_annotation/json_annotation.dart';

// لازم نعمل part 'api_error_model.g.dart'; عشان دة اسم الملف اللي بتكون فيه الكود اللي بتولد 
part 'api_error_model.g.dart';

//اي file بنعدل علية بيتعمله generate من @JsonSerializable او freezed
//ملحوظة هامة جداً : اي تغيير في mdel بتاعي
// اي تغيير في class retrofit "ApiService"بتاعي
//اي تغيير في State بتاع cubit
// ولان الفيلات "Auto generated files" يبقي لازم Build_runner
// dart run build_runner build --delete-conflicting-outputs

//@JsonSerializable عشان تعمل ملف "model"تختصر فيه الوقت

// اللي بيباصي الايرورز (الايرورز اللي بيباصي من الباك اند) بنعمله هندلينج
// @JsonSerializable  تعليم الكلاس إنه محتاج code generation
@JsonSerializable()
class ApiErrorModel {
  //message في الباك اند  معموله بال String
  final String? message;
  //code في الباك اند  معموله بال int
  final int? code;

  ApiErrorModel({
    required this.message,
    this.code,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
}