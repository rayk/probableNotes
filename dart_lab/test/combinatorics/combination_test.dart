import 'package:test/test.dart';
import 'package:dart_lab/src/combinatorics/combinations.dart';
import 'package:dart_lab/src/extensions/on_list.dart';

void main() {
  group('Combinations:', () {
    var members = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

    group('Combination using 4 elements from 8 members.', () {
      var comb = Combinations(4, members);

      test('Should return a representation of the combinations.', () {
        expect(comb.toString(), isNotNull);
        expect(comb.count, equals(members.countCombinationsOf(4)));
        expect(comb.size, equals(4));
      });

      test('Should return first combination.', () {
        expect(comb[0], equals(['A', 'B', 'C', 'D']));
      });

      test('Should return second combination.', () {
        expect(comb[1], equals(['A', 'B', 'C', 'E']));
      });

      test('Should return center combination.', () {
        expect(comb[comb.count ~/ BigInt.two], equals(['A', 'B', 'C', 'G']));
      });

      test('Should return second last combination.', () {
        expect(comb[comb.count - BigInt.one], equals(['A', 'B', 'D', 'E']));
      });

      test('Should return last combination.', () {
        expect(comb[comb.count], equals(['A', 'B', 'D', 'F']));
      });
    });

    group('Combination using boundary values.', () {
      var combineAll = Combinations(members.length, members);
      var combineOne = Combinations(1, members);

      test('Should return only 1 combination with all items.', () {
        expect(combineAll[0], equals(members));
      });

      test('Should return 8 combinations, one for each element.', () {
        expect(combineOne[0], equals(['A']));
        expect(combineOne[1], equals(['B']));
        expect(combineOne[2], equals(['C']));
        expect(combineOne[3], equals(['D']));
        expect(combineOne[4], equals(['E']));
        expect(combineOne[5], equals(['F']));
        expect(combineOne[6], equals(['G']));
        expect(combineOne[7], equals(['H']));
      });
    });
    
    group('Lookup Combinations:', () {
      var largeCombo = Combinations(4, members);
      
      test('Should return true when combination exist.', () {
        expect(largeCombo.contains(largeCombo[4]), isTrue);
      });
      
      test('Should return false when combination does not exist.', () {
        expect(largeCombo.contains(['w','x','y','z']), isFalse);
      });
    });
  });
}
