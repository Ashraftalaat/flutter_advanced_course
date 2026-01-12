import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

//مكتبة بتساعدك تعمل Immutable Classes (كلاسات غير قابلة للتعديل)
@freezed
//<T>: Generic Type - يعني الكلاس بيقبل أي نوع
//في حالتنا T هيكون LoginResponse

//with _$LoginState<T>
//بيستخدم الـ Mixin المولد من Freezed
//الـ _$LoginState<T> تلقائياً بيتولد في الملف 
//.freezed.dart
class LoginState<T> with _$LoginState<T> {
  //Initial: أول ما الشاشة تفتح (حالة البداية)
  const factory LoginState.initial() = _Initial;
  
  //Loading: لما نعمل request ونستنى الرد (عرض loader)
  const factory LoginState.loading() = Loading;
  
  //Success: لما نحصل على نتائج (عرض النتائج)
  const factory LoginState.success(T data) = Success<T>;
  
  //Error: لما نحصل على خطأ (عرض الخطأ)
  const factory LoginState.error({required String error}) = Error;
}
