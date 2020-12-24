import 'dart:math';

final _unprotectedFactCache = {0: 1, 1: 1};

/// Extensions for [int] type.
extension OnInt on int {
  /// Returns the factorial of this int.
  int get factorial {
    // calculates the factorial of n.
    int calcFactorial(int n) {
      for (var i = 2; i <= n; i += 1) {
        if (!_unprotectedFactCache.containsKey(i)) {
          _unprotectedFactCache[i] = _unprotectedFactCache[i - 1] * i;
        }
      }
      return _unprotectedFactCache[n];
    }

    // approximation of factorial n.
    int approxFactorial(int n) =>
        (sqrt(2 * pi * n) * pow((n / e), n)).ceil();

    return this == 0 || this == 1
        ? 1
        : this <= 21
            ? calcFactorial(this)
            : approxFactorial(this);
  }
}
