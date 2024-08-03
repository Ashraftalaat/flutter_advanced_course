import 'package:flutter_complete_project/core/helpers/app_regex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Password Validation tests', () {
    testValidPasswords();
    testInvalidPasswords();
  });
}

void testValidPasswords() {
  // Given
  final validPasswords = [
    'Test@123',
    'Test@1234Test@1234',
    'Test@1234Test@1234Test@1234',
  ];
  for (var password in validPasswords) {
    test('Given a valid password ($password), then expect true.', () {
      // When
      var result = AppRegex.isPasswordValid(password);

      // Then
      expect(result, true);
    });
  }
}

void testInvalidPasswords() {
  // Given
  final invalidPasswords = [
    'test1234', // Missing uppercase
    'TEST1234', // Missing lowercase
    'TestTest', // Missing number
    'Test@', // Missing number
    'Test1234Test1234', // Missing special character
    'Test@12', // Less than 8 characters
    'Test@ 1234', // Invalid characters
    'Test@1234 ', // Leading/trailing spaces
    '', // Empty string
  ];

  for (var password in invalidPasswords) {
    test('Given an invalid password ($password), then expect false.', () {
      // When
      var result = AppRegex.isPasswordValid(password);

      // Then
      expect(result, false);
    });
  }
}
