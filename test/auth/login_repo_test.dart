import 'package:flutter_complete_project/features/login/data/models/login_response.dart';
import 'package:flutter_complete_project/features/login/data/repos/login_repo.dart';
import 'package:flutter_complete_project/features/login/data/models/login_request_body.dart';
import 'package:flutter_complete_project/core/networking/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'login_repo_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService mockApiService;
  late LoginRepo loginRepo;

  setUp(() {
    mockApiService = MockApiService();
    loginRepo = LoginRepo(mockApiService);
  });

  test('Successful login returns success result', () async {
    final requestBody =
        LoginRequestBody(email: 'test@example.com', password: 'Test@1234');
    final loginResponse = LoginResponse(
      status: true,
      message: 'Success',
      loginUserData: LoginUserData(token: 'token', userName: 'username'),
      code: 200,
    );

    when(mockApiService.login(requestBody))
        .thenAnswer((_) async => loginResponse);

    final result = await loginRepo.login(requestBody);
    result.when(
      success: (data) {
        expect(data, loginResponse);
      },
      failure: (error) {
        fail('Expected success but got failure');
      },
    );
  });

}
