/// A Calculator.
class Fibonacci {

  final Map<int, int> _memo = {};

  int calculate(int n) {
    if (n <= 0) throw ArgumentError('n must be > 0');
    if (n <= 2) return 1;
    if (_memo.containsKey(n)) return _memo[n]!;
    final result = calculate(n - 1) + calculate(n - 2);
    _memo[n] = result;
    return result;
  }
}
