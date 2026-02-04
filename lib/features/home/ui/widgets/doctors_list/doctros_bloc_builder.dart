import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/home_cubit.dart';
import '../../../logic/home_state.dart';
import 'doctors_list_view.dart';

class DoctorsBlocBuilder extends StatelessWidget {
  const DoctorsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      //امتي تعمل build in لما الحالة تكون doctorsSuccess او doctorsError
      buildWhen: (previous, current) =>
          current is DoctorsSuccess || current is DoctorsError,
      builder: (context, state) {
        return state.maybeWhen(
          doctorsSuccess: (doctorsList) {
            return setupSuccess(doctorsList);
          },
          doctorsError: () => setupError(),
          // orElse لو الحالة مش من الاتنين اللي فوق
          orElse: () {
            //  بترجع shrink box فاضي
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget setupSuccess(doctorsList) {
    return DoctorsListView(
      doctorsList: doctorsList,
    );
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}
