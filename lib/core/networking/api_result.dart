import 'package:flutter_complete_project/core/networking/api_error_handler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// لازم نعمل part 'api_result.freezed.dart'; عشان دة اسم الملف اللي بتكون فيه الكود اللي بتولد  
part 'api_result.freezed.dart';

//بنستخدم ApiResult بدل مكتبة dartZ 
//اللي بتدي left & right اي success & failure
@Freezed()
//Wrapper للنتيجة - بيرجع Success أو Failure
// <T> يعني انها بتقبل اي حاجة
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.failure(ErrorHandler errorHandler) = Failure<T>;
}
