import '_base.dart';
import '../extensions/extensions.dart';

class Permutations<T> extends Combinatorics<T> {
  List<T> _sourceElements = [];
  BigInt _permCount;
  int _permLength;
  
  /// Returns the size of each permutations.
  int get size => _permLength;

  Permutations(int r, List<T> elements) {
    r < 0 || r > elements.length
        ? throw ArgumentError('Can`t take $r elements from ${elements.length}')
        : !elements.isEachUnique
            ? throw ArgumentError('Each element must be unique.')
            : null;
    
    _permCount = elements.countPermutationsOf(r);
    _permLength = r;
    _sourceElements = List<T>.from(elements, growable: false);
  }

  @override
  List<T> operator [](Object k) {
    // TODO: implement []
    throw UnimplementedError();
  }
}
