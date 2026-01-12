
import 'package:json_annotation/json_annotation.dart';
part 'login_request_body.g.dart';

//	Model البيانات المرسلة للـ API
// login_request_body: Model بتحدد البيانات اللي هنبعتها في طلب تسجيل الدخول
@JsonSerializable()
class LoginRequestBody{
  final String email;
  final String password;

  LoginRequestBody({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);
}