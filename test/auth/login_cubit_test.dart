import 'package:flutter_complete_project/core/networking/api_result.dart';
import 'package:flutter_complete_project/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_complete_project/features/login/logic/cubit/login_state.dart';
import 'package:flutter_complete_project/features/login/data/repos/login_repo.dart';
import 'package:flutter_complete_project/features/login/data/models/login_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'login_cubit_test.mocks.dart';

//class MockLoginCubit extends MockCubit implements LoginCubit {}

@GenerateMocks([LoginRepo])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockLoginRepo mockLoginRepo;

  setUp(() {
    mockLoginRepo = MockLoginRepo();
  });

  group('LoginCubit tests', () {
    blocTest<LoginCubit, LoginState<LoginResponse>>(
      'emits [Loading, Success] when login is successful',
      build: () {
        final loginResponse = LoginResponse(
          status: true,
          message: 'Success',
          loginUserData: LoginUserData(token: 'token', userName: 'username'),
          code: 200,
        );
        when(mockLoginRepo.login(any))
            .thenAnswer((_) async => ApiResult.success(loginResponse));
        return LoginCubit(mockLoginRepo);
      },
      act: (cubit) {
        cubit.emailController.text = 'test@example.com';
        cubit.passwordController.text = 'Test@1234';
        cubit.emitLoginStates();
      },
      expect: () => [
        isA<LoginLoading<LoginResponse>>(),
        isA<LoginSuccess<LoginResponse>>().having(
            (state) => state.data,
            'data',
            isA<LoginResponse>()
                .having((data) => data.loginUserData?.token, 'token', 'token'))
      ],
    );
  });
}
