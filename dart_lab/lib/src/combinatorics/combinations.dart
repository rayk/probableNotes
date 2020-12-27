import '../extensions/extensions.dart';
import '_base.dart';

/// A collection of all possible combinations of a set of unique elements
/// where each combination contains a fixed number of the unique elements
/// without consideration for ordering and replacement is not allowed.
class Combinations<T> extends Combinatorics<T> {
  // Number of members in each combination.
  int _r;
  // Order list of members which this combinations was created.
  List<T> _items;

  /// Builds combinations from [members] with each having a length of [r].
  ///
  /// Elements are not replaced after they have been using a combination.
  Combinations(int r, List<T> members) {
    if (r < 0 || r > members.length) {
      throw ArgumentError(
          'Can not make combinations of $r from ${members.length} members.');
    }
    if (!members.isEachUnique) {
      throw ArgumentError('list contains duplicate members.');
    }
    _items = List<T>.from(members, growable: false);
    _r = r;
  }

  /// Returns the size of each generated combination.
  int get size => _r;

  /// Return a count of the number of generated combinations.
  BigInt get count => _items.countCombinationsOf(_r);

  /// Returns the index that can be used to retrieve a generated combination
  /// that matches [combination].
  BigInt indexOf(List<T> combination, [BigInt start]) {
    BigInt combIdx;
    start = start ?? BigInt.zero;

    if (contains(combination)) {
      combIdx = inverseCombination(combination, _items);
      if (combIdx >= start) {
        return combIdx;
      }

      if (combIdx < start) {
        combIdx = BigInt.from(-1);
      }
    } else {
      combIdx = BigInt.from(-1);
    }

    return combIdx;
  }

  @override
  List<T> operator [](Object k) {
    BigInt idx = biIdxKey(k);
    return combination(
        adjIdxKey(idx, BigInt.from(_items.length)), size, _items);
  }

  /// Returns true when [x] in contains in the combinations elements.
  bool contains(Object x) =>
      _items.containsEveryItemIn(x) && _items.isEachUnique;

  @override
  String toString() {
    var sb = StringBuffer();
    sb.writeln('\nCombinations From:');
    sb.writeln(_items.toString());
    sb.writeln(
        '-> ${count.toString()} combinations generated, each containing $size elements.');
    return sb.toString();
  }
}
