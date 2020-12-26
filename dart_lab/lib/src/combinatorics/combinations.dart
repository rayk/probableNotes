import '../extensions/extensions.dart';
import '_base.dart';

/// Combinations [members] <T> of length [r].
class Combinations<T> extends Combinatorics<T> {
  
  // Number of members in each combination.
  int _r;
  
  /// Builds combinations.
  Combinations(int r, List<T> members) {
    if (r < 0 || r > members.length) {
      throw ArgumentError(
          'Can not make combinations of $r from ${members.length} members.');
    }
    if (!members.isEachUnique) {
      throw ArgumentError('list contains duplicate members.');
    }
    
    _r = r;
  }
  
  /// Returns the number of elements in generated combination.
  int get size => _r;

  @override
  List<T> operator [](Object k) {

  }
  
}
