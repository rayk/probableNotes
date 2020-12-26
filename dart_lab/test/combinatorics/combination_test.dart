import 'package:test/test.dart';
import 'package:dart_lab/src/combinatorics/combinations.dart';

void main() {
    group('Combinations:', () {
      var members = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
      
      group('Combination of 4 from members.', () {
        var comb = Combinations(4, members);
      });
    });
}