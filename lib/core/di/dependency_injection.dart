import 'package:dio/dio.dart';
import 'package:flutter_complete_project/core/networking/api_service.dart';
import 'package:flutter_complete_project/core/networking/dio_factory.dart';
import 'package:flutter_complete_project/features/home/data/apis/home_api_service.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/data/repos/home_repo.dart';
import '../../features/login/data/repos/login_repo.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/sign_up/data/repos/sign_up_repo.dart';
import '../../features/sign_up/logic/sign_up_cubit.dart';
/*
DI (Dependency Injection) = binding في GetX 


📚 ما هي مكتبة GetIt؟
GetIt هي مكتبة Service Locator بتساعدك:

تسجل (register) الـ dependencies مرة واحدة
تجيبها (get) من أي مكان في التطبيق
تتحكم في دورة حياتها
الشعار:

"Register once, use everywhere" 🌍

بنستورد كل الـ dependencies اللي هنحتاجها
Dio, ApiService, Repositories, Cubits
المكتبة الرئيسية: get_it
*/

/*
🎨 أنواع التسجيل في GetIt
النوع	الاستخدام	متى يتم الإنشاء؟	Instance جديد؟
registerSingleton	getIt.registerSingleton(MyClass())	فوراً (eager)	❌ نفس الـ instance
registerLazySingleton	getIt.registerLazySingleton(() => MyClass())	أول طلب (lazy)	❌ نفس الـ instance
registerFactory	getIt.registerFactory(() => MyClass())	كل طلب	✅ instance جديد
*/



//GetIt.instance: Singleton instance من GetIt
//final getIt: متغير global نستخدمه في كل التطبيق
//الاستخدام
// في أي ملف:
// final loginCubit = getIt<LoginCubit>();
final getIt = GetIt.instance;
//دالة بتسجل كل الـ dependencies
//متى نستدعيها؟ في main() قبل runApp()
Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  //Lazy Singleton: بيتعمل مرة واحدة بس، أول ما حد يطلبه
  //Singleton: نفس الـ instance يرجع كل مرة
  //Lazy: مش بيتعمل instantiate لحد ما حد يطلبه
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login 
  // الذكاء:
  // GetIt بيعرف إنك عايز ApiService عشان:
  // LoginRepo(this._apiService) // ← الـ type معرّف
  // LoginRepo: Singleton (مرة واحدة)
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  //Factory: كل مرة تطلبه، بيعمل instance جديد
  //ليه Factory مش Singleton؟
  //الـ Cubit بيدير state
  //كل Screen محتاج Cubit خاص بيها
  //لو استخدمنا Singleton، كل الـ screens هتشارك نفس الـ state!
  //بيجيب LoginRepo من GetIt
  //GetIt بيعرف إن LoginCubit محتاج LoginRepo
  //ونعمله instance جديد كل مرة
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
 
  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  // home
  //لماذا HomeApiService منفصل عن ApiService؟
  // ApiService: للـ Auth endpoints (Login, Signup)
  // HomeApiService: للـ endpoints الخاصة بالـ Home
  //فصل المسؤوليات: كل feature لها API service خاص
  getIt.registerLazySingleton<HomeApiService>(() => HomeApiService(dio));
  //بيجيب HomeApiService من GetIt
  //GetIt بيعرف إن HomeRepo محتاج HomeApiService
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
} 
