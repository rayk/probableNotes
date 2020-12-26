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
      countPermutationsOf(items) ~/ BigInt.from(items.factorial);

  /// Returns the count of possible permutations usint the given
  /// number of [items] from this list.
  BigInt countPermutationsOf(int items) =>
      BigInt.from(length.factorial) ~/ BigInt.from((length - items).factorial);

  /// Returns the total number of combination possible using
  /// all the items in this list.
  BigInt get combinations => countCombinationsOf(this.length);

  /// Returns the total number of permutations possible using
  /// all the items in this list.
  BigInt get permutations => countPermutationsOf(this.length);
}
