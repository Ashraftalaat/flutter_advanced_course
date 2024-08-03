import 'package:flutter_complete_project/core/helpers/app_regex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Email Validation tests', () {
    testValidEmails();
    testInvalidEmails();
  });
}

void testValidEmails() {
  // Given
  final validEmails = [
    'test@example.com',
    'test@mail.example.com',
  ];
  for (var email in validEmails) {
    test('Given a valid email ($email), then expect true.', () {
      // When
      var result = AppRegex.isEmailValid(email);

      // Then
      expect(result, true);
    });
  }
}

void testInvalidEmails() {
  // Given
  final invalidEmails = [
    'testexample.com', // Missing '@' symbol
    'test@.com', // Missing domain
    'test@example', // Missing top-level domain
    'test@ex!ample.com', // Invalid characters
    'test@@example.com', // Multiple '@' symbols
    ' test@example.com ', // Leading/trailing spaces
    '', // Empty string
  ];

  for (var email in invalidEmails) {
    test('Given an invalid email ($email), then expect false.', () {
      // When
      var result = AppRegex.isEmailValid(email);

      // Then
      expect(result, false);
    });
  }
}
