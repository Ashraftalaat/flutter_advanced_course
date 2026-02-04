import 'package:flutter_complete_project/core/helpers/extensions.dart';
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
  @JsonKey(name: "data")
  final Map<String, dynamic>? errors;

  ApiErrorModel({
    this.message,
    this.code,
    this.errors,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

///  بترجع كل الايرور ميسجز في الماب errors
  String? getAllErrorMessages(){
if (errors.isNullOrEmpty()) return message ?? "Unknown error occurred";
      // entry يعني كل عنصر في الماب
     // entry هو عبارة عن MapEntry<K, V>  اللي هو بيحتوي علي key , value
     final errorMessage = errors!.entries.map((entry) {
    // يعني هناخد ال value بتاع  وهو entry الواحد
     final value =entry.value;
     return "${value.join(",")}";
   }).join("\n");
   
   return errorMessage;
}
  
}