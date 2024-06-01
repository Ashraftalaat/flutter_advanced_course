import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/features/home/logic/home_cubit.dart';
import 'package:flutter_complete_project/features/home/logic/home_state.dart';
import 'package:flutter_complete_project/features/home/ui/widgets/doctors_speciality_list_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsSpecialityListView extends StatelessWidget {
  const DoctorsSpecialityListView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getSpecializations();
    return BlocBuilder<HomeCubit, HomeState>(
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
            var specializationsList = specializationsResponseModel.specializationDataList;
            return SizedBox(
              height: 100.h,
              child: ListView.builder(
                itemCount: specializationsList?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return DoctorsSpecialityListItem(
                    itemIndex: index,
                    specializationsData: specializationsList?[index],
                  );
                },
              ),
            );
          },
          specializationsError: (error) => const SizedBox(),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
