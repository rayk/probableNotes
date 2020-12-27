import 'dart:math';

import 'package:dart_lab/src/extensions/extensions.dart';

/// Returns an index in the domain [0, n[.
BigInt adjIdxKey(BigInt k, BigInt n) => k % n;

/// Returns BigInt Index Key.
BigInt biIdxKey(Object idx) => idx is int
    ? BigInt.from(idx)
    : idx is BigInt
        ? idx
        : throw ArgumentError('An Index must be an integer or BigInt.');

/// Returns the `k`th combination, generated from [elements] where each
/// combination is [combSize] long.
List<T> combination<T>(BigInt kTh, int combSize, List<T> elements) {
  if (combSize == 0) {
    return <T>[];
  }

  final elementCount = elements.length;

  int pos = 0;
  int startPos = elementCount - 1;

  BigInt d = countCombinations(startPos, combSize - 1);

  while (kTh >= d) {
    kTh -= d;
    pos += 1;
    d = countCombinations(elementCount - pos - 1, combSize - 1);
  }

  var tail = elements.sublist(pos.toInt() + 1);
  return [elements[pos.toInt()]]
    ..addAll(combination<T>(kTh, combSize - 1, tail));
}

/// Returns the number of arrangements of [sampleSize] length that can be
/// created from [elementCount] distinct elements.
BigInt countCombinations(int elementCount, int sampleSize) =>
    countPermutations(elementCount, sampleSize) ~/ sampleSize.factorial;

/// The number of ways to choose a sample of [sampleSize] elements from a set of
/// distinct [elementCount] where order does matter and replacements are not allowed.
/// When items = size this reduces to n!, a simple factorial of n.
BigInt countPermutations(int elementCount, int sampleSize) =>
    elementCount.factorial ~/ (elementCount - sampleSize).factorial;

/// Returns the index of combination in the order list of [combinations] of
/// combinations items taken from [elements].
BigInt inverseCombination<T>(List<T> combinations, List<T> elements) {
  if (combinations.isEmpty) {
    return BigInt.zero;
  }

  int r = combinations.length, n = elements.length, eleIdx = 0;
  BigInt k = BigInt.zero;

  while (combinations[0] != elements[eleIdx.toInt()]) {
    k += countCombinations(n - eleIdx - 1, r - 1);
    eleIdx += 1;
  }

  return k +
      inverseCombination<T>(
          combinations.sublist(1), elements.sublist((eleIdx + 1).toInt()));
}

BigInt inversePermutation<T>(List<T> permutations, List<T> elements) {
  int r = permutations.length;
  if (r == 0) {
    return BigInt.zero;
  }

  var sortedPermutation = sortArrangement<T>(permutations, elements);
  BigInt group = inverseCombination<T>(sortedPermutation, elements);
  return group * r.factorial +
      _inversePermutationWorker<T>(permutations, sortedPermutation);
}

/// Returns the `k`th permutation, generated from [elements].
List<T> permutation<T>(BigInt kTh, int permSize, List<T> elements) {
  BigInt fact = permSize.factorial, group = kTh ~/ fact, item = kTh % fact;
  List<T> combo = combination<T>(group, permSize, elements);
  return _permutationWorker<T>(item, combo);
}

/// Returns the items in [arrangement] in the same order as they appear in
/// [elements]
List<T> sortArrangement<T>(List<T> arrangement, List<T> elements) =>
    (List<T>.from(arrangement))
      ..sort((x, y) => elements.indexOf(x).compareTo(elements.indexOf(y)));

List<T> _permutationWorker<T>(BigInt kTh, List<T> items) {
  int n = items.length;
  if (n <= 1) {
    return items;
  } else {
    BigInt biN = BigInt.from(n),
        group = (kTh ~/ biN),
        mod = kTh % biN,
        pos = group % BigInt.two == BigInt.zero ? biN - mod - BigInt.one : mod;

    return _permutationWorker<T>(group, items.sublist(0, n - 1))
      ..insert(pos.toInt(), items[n - 1]);
  }
}

BigInt _inversePermutationWorker<T>(
    List<T> permutations, List<T> sortedPermutations) {
  if (permutations.length == 1) {
    return BigInt.zero;
  }
  int n = sortedPermutations.length;

  BigInt biN = BigInt.from(n),
      index = BigInt.from(permutations.indexOf(sortedPermutations.last)),
      group = _inversePermutationWorker<T>(
          permutations.where((x) => x != sortedPermutations.last).toList(),
          sortedPermutations.sublist(0, sortedPermutations.length - 1));
  return biN * group +
      (group % BigInt.two == BigInt.zero ? biN - index - BigInt.one : index);
}

/// Base class for all combinatorics counting.
abstract class Combinatorics<T> {
  // Input Member elements.
  List<T> _elements;
  BigInt _length;

  /// Returns an iterable with all the specified arrangements of the members.
  Iterable get iterable => this();

  /// Returns all the member elements from which object are selected.
  List<T> get members => List<T>.from(_elements, growable: false);

  /// The k th arrangement.
  List<T> operator [](Object k);

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

  Iterable<List<T>> _range(BigInt from, BigInt to) sync* {
    do {
      yield this[adjIdxKey(from, _length)];
      from += BigInt.one;
    } while (adjIdxKey(from, _length) != adjIdxKey(to, _length));
  }
}
