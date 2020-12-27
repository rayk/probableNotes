import 'dart:math';

/// Private cache used for the calculation factorial.
final _unprotectedFactCache = {0: 1, 1: 1};

/// Extensions for [int] type.
extension OnInt on int {
  /// Approximate factorial when n greater then this value.
  static const int thresholdForApprox = 20;

  /// Returns the factorial of this int, (n!).
  ///
  /// For n <= 30 a value is calculated, for higher values
  /// a Stirling approximation of factorial is returned.
  BigInt get factorial {
    
    // Calculates the factorial of n.
    int calcFactorial(int n) {
      for (var i = 2; i <= n; i += 1) {
        if (!_unprotectedFactCache.containsKey(i)) {
          _unprotectedFactCache[i] = _unprotectedFactCache[i - 1] * i;
        }
      }
      return _unprotectedFactCache[n];
    }

    // Stirling's factorial approximation of n.
    num approxFactorial(int n) => (sqrt(2 * pi * n) * pow((n / e), n));

    return this == 0 || this == 1 || this <= -1
        ? BigInt.one
        : this <= thresholdForApprox
            ? BigInt.from(calcFactorial(this))
            : BigInt.from(approxFactorial(this));
  }
}
