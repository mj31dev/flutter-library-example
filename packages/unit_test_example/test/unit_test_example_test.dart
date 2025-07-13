import 'package:flutter_test/flutter_test.dart';

import 'package:unit_test_example/unit_test_example.dart';

void main() {
  group('Fibonacci', () {
    final fibonacci = Fibonacci();
    test('Base cases', () {
      expect(fibonacci.calculate(1), equals(1));
      expect(fibonacci.calculate(2), equals(1));
    });

    test('General cases', () {
      expect(fibonacci.calculate(3), equals(2));
      expect(fibonacci.calculate(5), equals(5));
      expect(fibonacci.calculate(10), equals(55));
      expect(fibonacci.calculate(20), equals(6765));
    });

    test('Invalid input throws error', () {
      expect(() => fibonacci.calculate(0), throwsArgumentError);
      expect(() => fibonacci.calculate(-5), throwsArgumentError);
    });
  });
}
