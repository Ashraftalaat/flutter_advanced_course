import 'package:flutter_complete_project/core/networking/api_error_handler.dart';
import 'package:flutter_complete_project/core/networking/api_result.dart';
import 'package:flutter_complete_project/core/networking/api_service.dart';
import 'package:flutter_complete_project/features/login/data/models/login_request_body.dart';
import 'package:flutter_complete_project/features/login/data/models/login_response.dart';

//الـ Repository هو طبقة وسيطة بين الـ 
//UI (Cubit/Bloc) وبين
// مصادر البيانات (API, Database, Cache)

/*
UI (Screens/Widgets)
    ↓
Business Logic (Cubit/Bloc)
    ↓
Repository ←← إحنا هنا! 
    ↓
Data Sources (API Service)
    ↓
Network (Dio)
*/

//كلاس عادي (مش abstract)
//مسؤول عن كل العمليات المتعلقة بـ Login
//بيتعامل مع الـ data layer

class LoginRepo {
  //LoginRepo → يعتمد على → ApiService → يعتمد على → Dio
  final ApiService _apiService;
//LoginRepo بيعتمد على ApiService ذي ما  ApiService بيعتمد على Dio 
  LoginRepo(this._apiService);
//ApiResult عشان نعرف الراجع Success Or Failure 
  Future<ApiResult<LoginResponse>> login(
    // الدالة بتاخد LoginRequestBody فيه (email, password)
      LoginRequestBody loginRequestBody) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }
}
