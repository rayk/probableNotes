import 'dart:math';
import 'package:dart_lab/src/extensions/extensions.dart';

/// Base class for all combinatorics counting.
abstract class Combinatorics<T> {
  // Input Member elements.
  List<T> _elements;
  BigInt _length;

  /// Returns all the member elements from which object are selected.
  List<T> get members => List<T>.from(_elements, growable: false);

  /// Returns an iterable with all the specified arrangements of the members.
  Iterable get iterable => this();

  Iterable<List<T>> _range(BigInt from, BigInt to) sync* {
    do {
      yield this[adjIdxKey(from, _length)];
      from += BigInt.one;
    } while (adjIdxKey(from, _length) != adjIdxKey(to, _length));
  }

  /// Returns
  Iterable<List<T>> call([Object fromTo, Object to]) {
    BigInt fromKey, toKey;

    if (fromTo == null && to == null) {
      fromKey = BigInt.zero;
      toKey = _length;
    } else {
      if (fromTo is int) {
        fromKey = BigInt.from(fromTo);
      } else if (fromTo is BigInt) {
        fromKey = fromTo;
      } else {
        throw Exception('Expecting int or BigInt in range.');
      }
      if (to == null) {
        toKey = fromKey;
        ;
        fromKey = BigInt.zero;
      } else {
        if (to is int) {
          toKey = BigInt.from(to);
        } else if (to is BigInt) {
          toKey = to;
        } else {
          throw Exception('Expecting int or BigInt in range.');
        }
      }
    }

    return _range(fromKey, toKey);
  }

  /// Returns range of member defined [fromTo] index.
  Iterable<List<T>> range(Object fromTo, [Object to]) {
    BigInt fromKey = biIdxKey(fromTo), toKey;

    if (to == null) {
      toKey = fromKey;
      fromKey = BigInt.zero;
    } else {
      toKey = biIdxKey(to);
    }

    if (fromKey == toKey) {
      return Iterable.empty();
    }

    return _range(fromKey, toKey);
  }

  /// Returns an sample from all the arrangements of the members.
  Iterable sample(int n, {int seed, bool withReplacement = false}) {
    // Returns a random index key
    BigInt indexSelector() {
      final rand = seed == null ? Random() : Random(seed);
      var idx = BigInt.zero, bits = _length.bitLength + 1;

      for (var i = 0; i < bits; i++) {
        idx += rand.nextBool() ? BigInt.one : BigInt.two;
        if (i < bits - 1) {
          idx <<= 1;
        }
        if (idx > _length - BigInt.one) {
          idx = BigInt.zero;
          i = 0;
        }
      }
      return idx;
    }

    if (withReplacement) {
      return List<BigInt>.generate(n, (_) => indexSelector())
          .map((e) => this[e]);
    } else {
      if (BigInt.from(n) > _length) {
        throw ArgumentError(
            'Can not take more than $_length, without replacement');
      }
      var indices = <BigInt>{};
      while (indices.length < n) {
        indices.add(indexSelector());
      }
      return indices.map((e) => this[e]);
    }
  }

  /// The k th arrangement.
  List<T> operator [](Object k);
}

/// Returns BigInt Index Key.
BigInt biIdxKey(Object idx) => idx is int
    ? BigInt.from(idx)
    : idx is BigInt
        ? idx
        : throw ArgumentError('An Index must be an integer or BigInt.');

/// Returns an index in the domain [0, n[.
BigInt adjIdxKey(BigInt k, BigInt n) => k % n;

/// The number of ways to choose a sample of [size] elements from a set of
/// distinct [items] where order does matter and replacements are not allowed.
/// When items = size this reduces to n!, a simple factorial of n.
BigInt countPermutations(int items, int size) =>
    BigInt.from(items.factorial ~/ (items - size).factorial);

BigInt countCombination(int itemCount, int samples) =>
    countPermutations(itemCount, samples) ~/ BigInt.from(itemCount.factorial);

/// Returns the `k`th combination in list of combinations, where each
/// combination from [items] has a length of [r].
List<T> combination<T>(BigInt k, int r, List<T> items) {
  if (r == 0) {
    return <T>[];
  }

  int n = items.length, position = 0;

  BigInt d = countCombination(n - position - 1, r - 1);

  while (k >= d) {
    k -= d;
    position += 1;
    d = countCombination(n - position - 1, r - 1);
  }

  var tail = items.sublist(position.toInt() + 1);
  return [items[position.toInt()]]..addAll(combination<T>(k, r - 1, tail));
}
