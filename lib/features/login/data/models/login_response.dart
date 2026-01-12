import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

//Model البيانات الراجعة من الـ API
//login_response: Model بتحدد شكل البيانات اللي هترجع من الـ API
@JsonSerializable()
class LoginResponse {
  String? message;
  // عملنا @JsonKey عشان نغير اسم المفتاح اللي بيحصل من الباك اند
  @JsonKey(name: 'data')
  UserData? userData;
  bool? status;
  int? code;

  LoginResponse({this.message, this.userData, this.status, this.code});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  String? token;
  // عملنا @JsonKey عشان نغير اسم المفتاح اللي بيحصل من الباك اند
  @JsonKey(name: 'username')
  String? userName;

  UserData({this.token, this.userName});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
