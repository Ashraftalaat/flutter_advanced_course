
import 'package:flutter_complete_project/core/networking/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/specializations_response_model.dart';

part 'home_state.freezed.dart';

//بدلاً من إنشاء متغيرات bool isLoading و String error داخل كلاس واحد، نقوم بإنشاء "حالات" منفصلة
@freezed
class HomeState with _$HomeState {
  //initial: هي الحالة الأولى عند فتح الصفحة (قبل البدء في أي عملية)
  const factory HomeState.initial() = _Initial;

  // Specializations
  const factory HomeState.specializationsLoading() = SpecializationsLoading;
  //List<SpecializationsData?>? وهي القائمة التي ستعرضها في الواجهة
  const factory HomeState.specializationsSuccess(List<SpecializationsData?>? specializationDataList) = SpecializationsSuccess;
 // استخدمنا ApiErrorModel بدل ApiErrorHandler عشان بنرجعSuccess ام 
 // وعشان دة اللي في UI هيعرضلي الداتا اللي الماب شيلاها
  const factory HomeState.specializationsError(ApiErrorModel apiErrorModel) =
      SpecializationsError;

  // Doctors
  const factory HomeState.doctorsSuccess(List<Doctors?>? doctorsList) = DoctorsSuccess;
 //ApiErrorModel errorHandler
  const factory HomeState.doctorsError() =
      DoctorsError;
}
