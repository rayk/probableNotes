import 'dart:math';

import 'on_int.dart';

/// Extensions for [int] type.
extension OnList on List {
  /// Returns True when each item in this list is unique;
  bool get isEachUnique => this.toSet().length == this.length;

  /// Returns True when every item in this list is present in [other].
  bool containsEveryItemIn(List other) =>
      other.every((element) => contains(element));

  /// Returns the count of possible combination using the given
  /// number of [items] from this list.
  BigInt countCombinationsOf(int items) =>
      countPermutationsOf(items) ~/ items.factorial;

  /// Returns the count of possible permutations using the given
  /// number of [items] from this list.
  BigInt countPermutationsOf(int items) =>
      length.factorial ~/ (length - items).factorial;

  /// Returns the total number of combination possible using
  /// all the items in this list.
  BigInt get combinations => countCombinationsOf(this.length);

  /// Returns the total number of permutations possible using
  /// all the items in this list.
  BigInt get permutations => countPermutationsOf(this.length);
}

extension StatisticalMeasures on List<num> {
  List<num> get _copy => List.of(this, growable: false);

  /// Returns the minimum value contained in this list.
  num get min {
    var temp = _copy;
    temp.sort();
    return temp[0];
  }

  /// Returns the maximum value contain in this list.
  num get max {
    var temp = _copy;
    temp.sort();
    return temp[length - 1];
  }

  /// Returns the sum of all the elements in this list.
  num get sum => cast<num>().reduce((value, element) => value + element);

  /// Returns the product of all the elements in list.
  num get product => cast<num>().reduce((value, element) => value * element);

  /// Returns the value separating the height half form the lower half of the
  /// list of elements.
  num get median {
    final middle = length ~/ 2;
    final isEven = length % 2 == 0;
    var temp = _copy;
    temp.sort();
    return isEven ? (temp[middle - 1] + temp[middle]) / 2 : temp[middle];
  }

  /// Returns the value that appears with the highest frequency in the list.
  num get mode {}

  /// Returns the measure of central tendency of the values in the list.
  num get mean => sum / length;

  /// Returns the spread of elements in list from their average value.
  num get variance {
    var squareDifference = 0.0;
    for (var i = 0; i < length; i++) {
      squareDifference += (this[i] - mean) * (this[i] - mean);
    }
    return squareDifference / length;
  }

  /// Returns the dispersion of the elements in the list.
  num get standardDeviation => sqrt(variance);

  /// Returns a indicative value of the central tendency of lists elements.
  num get geometricMean => pow(product, 1 / length);

  /// Return a indicative value of the central of tendency when list elements
  /// represents rates, rather then arithmetic values.
  num get harmonicMean {
    var m = 0.0;
    for (var i = 0; i < length; i++) {
      m = m + (1) / this[i];
    }
    return length / m;
  }

  /// Returns an estimator of the variance of the elements mean in contrast
  /// with [other].
  double covarianceWith(List<double> other) {
    if (other.length != length) {
      throw ArgumentError('Length of other and this are not equal.');
    }

    var sum = 0.0;

    for (var i = 0; i < other.length; i++) {
      sum += ((this[i] - mean) * (other[i] - other.mean));
    }

    return sum / (length - 1);
  }
}
