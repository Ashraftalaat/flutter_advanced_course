import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/helpers/extensions.dart';
import 'package:flutter_complete_project/core/networking/api_error_model.dart';
import '../../../core/networking/api_error_handler.dart';
import '../data/models/specializations_response_model.dart';
import '../data/repos/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  List<SpecializationsData?>? specializationsList = [];

  void getSpecializations() async {
    emit(const HomeState.specializationsLoading());
    final response = await _homeRepo.getSpecialization();
    response.when(
      success: (specializationsResponseModel) {
        specializationsList =
            specializationsResponseModel.specializationDataList ?? [];

        // getting the doctors list for the first specialization
        // by default.
        getDoctorsList(specializationId: specializationsList?.first?.id);

        emit(HomeState.specializationsSuccess(
            specializationsResponseModel.specializationDataList));
      },
      failure: (apiErrorModel) {
        emit(HomeState.specializationsError(apiErrorModel));
      },
    );
  }

// فلترة الدكاترة بناءا علي التخصص
  void getDoctorsList({required int? specializationId}) {
    List<Doctors?>? doctorsList =
        getDoctorsListBySpecializationId(specializationId);
      //isNullOrEmpty موجودة في extension 
    if (!doctorsList.isNullOrEmpty()) {
      emit(HomeState.doctorsSuccess(doctorsList));
    } else {
      //ErrorHandler.handle('No doctors found')
      emit(const HomeState.doctorsError());
    }
  }

  /// returns the list of doctors based on the specialization id
  // specializationId دية الكليك علي التخصص بتديني ال id بتاعه
  getDoctorsListBySpecializationId(specializationId) {
    // specializationsList دية لستة الكاترة كلها كل عنصر فيها فيه id , name.. لكل تخصص
    return specializationsList
       // firstWhere بيجيبلي اول عنصر بتطابق الشرط اللي انا بديهاله
       // كأني بلوب علي العناصر بتاعت اللستة
       // بقوله اول عنصر  يقابلك id بتاعه بيساوي ال specializationId
        ?.firstWhere((specialization) => specialization?.id == specializationId)
       // هاتلي لستة الدكاترة بتاعته
        ?.doctorsList;
  }
}
