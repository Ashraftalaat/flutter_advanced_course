import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/helpers/extensions.dart';
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
        emit(HomeState.specializationsSuccess(specializationsList));
        // getting the doctors list for the first specialization by default.
        getDoctorsList(specializationId: 1);
      },
      failure: (errorHandler) {
        emit(HomeState.specializationsError(errorHandler));
      },
    );
  }

  /// Gets doctors list based on the selected specialization
  void getDoctorsList({required int? specializationId}) {
    List<Doctors?>? specializationDoctorsList =
        filterSpecializationsListById(specializationId);

    if (!specializationDoctorsList.isNullOrEmpty()) {
      emit(HomeState.doctorsSuccess(specializationDoctorsList));
    } else {
      emit(HomeState.doctorsError(ErrorHandler.handle('No doctors.')));
    }
  }

  filterSpecializationsListById(specializationId) {
    return specializationsList
        ?.firstWhere((specialization) => specialization?.id == specializationId)
        ?.doctorsList;
  }
}
