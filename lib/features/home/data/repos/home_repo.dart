import 'package:flutter_complete_project/core/networking/api_error_handler.dart';
import 'package:flutter_complete_project/core/networking/api_result.dart';
import 'package:flutter_complete_project/features/home/data/apis/home_api_service.dart';
import 'package:flutter_complete_project/features/home/data/models/specializations_response_model.dart';

class HomeRepo {
  final HomeApiService _homeApiService;

  HomeRepo(this._homeApiService);

  Future<ApiResult<SpecializationsResponseModel>> getSpecialization() async {
    try {
      final response = await _homeApiService.getSpecialization();
      return ApiResult.success(response);
    } catch (error) {
      // استخدمنا ApiErrorHandler لان وظيفة الريبو هو معرفة نتيجة Api 
      // هل هو success ام failure
      // فهو مش عارف هيرجع اية يعني المشكلة من  errors في الباك اند  ولا من فين
      // لذلك بنرجع الكلاس كله فبيمسك الاول Dioexception هل المشكلة منه ام من 
      //response  وبعدين بيرجعلي ApiErrorModel
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
