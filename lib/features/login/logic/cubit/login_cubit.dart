import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/helpers/constants.dart';
import 'package:flutter_complete_project/core/helpers/shared_pref_helper.dart';
import 'package:flutter_complete_project/core/networking/dio_factory.dart';
import 'package:flutter_complete_project/features/login/data/models/login_request_body.dart';
import 'package:flutter_complete_project/features/login/data/repos/login_repo.dart';
import 'package:flutter_complete_project/features/login/logic/cubit/login_state.dart';

/*
 كيف تتصل كل القطع مع بعض

 📱 UI Layer (Screens/Widgets)
         ↓
    BlocBuilder/BlocConsumer
         ↓
🧠 Business Logic Layer (Cubit) ← إحنا هنا!
         ↓
    emit(states)
         ↓
📦 Data Layer (Repository)
         ↓
🌐 Network Layer (ApiService)
         ↓
🔌 HTTP Client (Dio)
         ↓
🖥️ Backend Server
*/

/*
getIt<LoginCubit>()
    ↓
يحتاج LoginRepo
    ↓
getIt يجيب LoginRepo (LazySingleton)
    ↓
LoginRepo يحتاج ApiService
    ↓
getIt يجيب ApiService (LazySingleton)
    ↓
ApiService يحتاج Dio
    ↓
Dio موجود (متغير محلي)
    ↓
✅ LoginCubit جاهز!
*/

class LoginCubit extends Cubit<LoginState> {
  //LoginCubit → LoginRepo → ApiService → Dio → Backend
  final LoginRepo _loginRepo;
  //أول حالة لما الـ Cubit يتعمل
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    //الـ Cubit بيرسل state جديد
    //الـ UI بيسمع التغيير
    //BlocBuilder بيبني نفسه من جديد
    //UI بيعرض Loading indicator
    emit(const LoginState.loginloading());
    final response = await _loginRepo.login(
      LoginRequestBody(
        //بناخد النص من الـ Controllers:
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    //response.when
    //دالة من 
    //ApiResult
    // (اللي عملها Freezed)
    //بتخليك تتعامل مع الحالتين (success/failure) بشكل آمن
    //Type-safe: لو نسيت حالة، الكود مش هيشتغل
    response.when(success: (loginResponse) async {
      //استخراج الـ token وحفظه في الـ Shared Preferences
      await saveUserToken(loginResponse.userData?.token ?? '');
      // إرسال Success State:
      emit(LoginState.loginsuccess(loginResponse));
    }, failure: (apiErrorModel) {
      //emit(LoginState.error(...)): بنرسل Error state للـ UI
      emit(LoginState.loginerror(apiErrorModel));
    });
  }

  Future<void> saveUserToken(String token) async {
    //حفظ الـ token في الـ Shared Preferences مع تشفيره
    //باستخدام مكتبة FlutterSecureStorage.
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    //إضافة للـ Dio Headers: ماذا تفعل؟
    // بتضيف header جديد لكل الـ requests القادمة:
    //headers: {
    //  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
    //}
    //الفايدة:
    //الـ Backend بيعرف مين المستخدم في كل request
    //بنقدر نجيب بيانات خاصة بالمستخدم
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}
