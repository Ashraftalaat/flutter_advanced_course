import 'package:dio/dio.dart';
import 'package:flutter_complete_project/core/networking/api_constants.dart';
import 'package:flutter_complete_project/features/login/data/models/login_request_body.dart';
import 'package:flutter_complete_project/features/login/data/models/login_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/sign_up/data/models/sign_up_request_body.dart';
import '../../features/sign_up/data/models/sign_up_response.dart';

//الخدمة اللي بتعمل HTTP requests

/*
🎯 الفايدة الكاملة من الملفين
✅ 
api_service.dart
بتعرّف API endpoints بشكل نظيف وواضح
بتوفر مكان واحد لكل الـ API calls
سهلة الصيانة: لو عايز تضيف endpoint جديد، بتكتب سطرين بس
✅ 
api_service.g.dart
بتنفذ كل الكود المعقد تلقائياً
بتوفر وقت: مش محتاج تكتب كود الـ HTTP requests يدوياً
بتقلل الأخطاء: الكود المولد دقيق ومضمون
*/

// لازم نعمل part 'api_service.g.dart'; عشان دة اسم الملف اللي بتكون فيه الكود اللي بتولد
part 'api_service.g.dart';

//retrofit فوق Dio
// retrofit: مكتبة بتبني فوق Dio وبتسهل كتابة الـ API calls
//@RestApi: Annotation من مكتبة Retrofit
//بيقول لـ Retrofit إن ده كلاس API service ومحتاج code generation
@RestApi(baseUrl: ApiConstants.apiBaseUrl)
// abstract class: كلاس تجريدي (مش هنعمل instance منه مباشرة)
//Retrofit هو اللي هيعمل implementation للكلاس ده في الملف المولد
abstract class ApiService {
  //ApiService عملنا inject dio "depend dio"اي بيعتمد علي Dio
  //factory constructor: بيرجع instance من الكلاس
  //Dio dio: بياخد object من Dio (dependency injection)
  //= _ApiService: بيشير للكلاس المولد تلقائياً في api_service.g.dart
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  //************** اول Api call **************
  //************** login **************

  // @POST: Annotation بيحدد نوع الطلب (POST request)
  // ApiConstants.login: الـ endpoint (مثلاً: "auth/login")
  @POST(ApiConstants.login)
  // LoginResponse: نوع البيانات اللي هترجع من الـ API
  Future<LoginResponse> login(
  //@Body(): Annotation بيقول إن الباراميتر ده هيتبعت في body الـ request
    @Body() LoginRequestBody loginRequestBody,
  );

  //************** signup **************
  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(
    @Body() SignupRequestBody signupRequestBody,
  );
}
