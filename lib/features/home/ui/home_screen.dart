import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/helpers/extensions.dart';
import 'package:flutter_complete_project/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/routing/routes.dart';
import '../logic/home_cubit.dart';
import '../logic/home_state.dart';
import 'widgets/doctor_blue_container.dart';
import 'widgets/doctors_list_view.dart';
import 'widgets/doctors_speciality_list_item.dart';
import 'widgets/doctors_speciality_list_view.dart';
import 'widgets/doctors_speciality_see_all.dart';
import 'widgets/home_top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(
            20.w,
            16.h,
            20.w,
            28.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              const DoctorsBlueContainer(),
              verticalSpace(24),
              const DoctorsSpecialitySeeAll(),
              verticalSpace(16),
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    current is SpecializationsLoading ||
                    current is SpecializationsSuccess ||
                    current is SpecializationsError,
                builder: (context, state) {
                  return state.maybeWhen(
                    specializationsLoading: () {
                      return const SizedBox(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    specializationsSuccess: (specializationsResponseModel) {
                      var specializationsList =
                          specializationsResponseModel.specializationDataList;
                      return Expanded(
                        child: Column(
                          children: [
                            DoctorsSpecialityListView(
                              specializationDataList: specializationsList ?? [],
                            ),
                            verticalSpace(8),
                            DoctorsListView(
                              doctorsList: specializationsList?[0]?.doctorsList,
                            ),
                          ],
                        ),
                      );
                    },
                    specializationsError: (errorHandler) {
                      debugPrint("specializationsError: $errorHandler");
                      if (errorHandler.apiErrorModel.code == 401) {
                        return InkWell(
                          onTap: () async {
                            await SharedPrefHelper.removeData(
                                SharedPrefKeys.userToken);
                            if (context.mounted) {
                              context.pushNamedAndRemoveUntil(
                                  Routes.loginScreen,
                                  predicate: (route) => false);
                            }
                          },
                          child: const SizedBox(
                            height: 100,
                            child: Center(
                              child: Text("Unauthorized, Please relogin!."),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                                "An error occurred, Please try again later."),
                          ),
                        );
                      }
                    },
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
              // const DoctorsSpecialityListView(),
              // verticalSpace(8),
              // const DoctorsListView(),
            ],
          ),
        ),
      ),
    );
  }
}
