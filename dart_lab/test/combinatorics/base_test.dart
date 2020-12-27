import 'package:dart_lab/src/combinatorics/combinations.dart';
import 'package:test/test.dart';
import 'package:dart_lab/src/combinatorics/_base.dart';
import 'package:dart_lab/src/extensions/on_list.dart';

void main() {
  var sourceElements = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
  ];
  
  group('Index:', () {
    test('Should return an idx key from an int.', () {
      expect(biIdxKey(5), equals(BigInt.from(5)));
    });

    test('Should return an adjusted idx to be inside the domain 0, n.', () {
      expect(adjIdxKey(BigInt.from(100), BigInt.from(68)),
          equals(BigInt.from(32)));
    });
  });

  group('Aligned Permutation & Combination Counting', () {
    var arrangementLengths = [2, 3, 4, 5];
    var stringElem = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    var intElm = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9];

    var comboStringExtCount = <int, BigInt>{};
    var comboIntExtCount = <int, BigInt>{};
    var permsStringExtCount = <int, BigInt>{};
    var permsIntExtCount = <int, BigInt>{};

    for (var l in arrangementLengths) {
      comboStringExtCount.addAll({l: stringElem.countCombinationsOf(l)});
      permsStringExtCount.addAll({l: stringElem.countPermutationsOf(l)});
      comboIntExtCount.addAll({l: intElm.countCombinationsOf(l)});
      permsIntExtCount.addAll({l: intElm.countPermutationsOf(l)});
    }

    group('Permutations:', () {
      for (var l in arrangementLengths) {
        test('Should return permutations with length $l from string list.', () {
          expect(countPermutations(stringElem.length, l),
              equals(permsStringExtCount[l]));
        });

        test('Should return permutations with length $l from int list.', () {
          expect(
              countPermutations(intElm.length, l), equals(permsIntExtCount[l]));
        });
      }
    });

    group('Combinations:', () {
      for (var l in arrangementLengths) {
        test('Should return combination with length $l from string list.', () {
          expect(countCombinations(stringElem.length, l),
              equals(comboStringExtCount[l]));
        });

        test('Should return combination with length $l from int list.', () {
          expect(countCombinations(intElm.length, l),
              equals(intElm.countCombinationsOf(l)));
        });
      }
    });
  });

  group('Generated Combinations:', () {
   

    test('Should return the 4th generated combination of size 5.', () {
      expect(combination(BigInt.from(4), 5, sourceElements),
          equals(['A', 'B', 'C', 'D', 'I']));
    });

    test('Should return the 27th generated combination of size 5.', () {
      expect(combination(BigInt.from(27), 5, sourceElements),
          equals(['A', 'B', 'C', 'J', 'K']));
    });
  });

  group('Generated Permutations:', () {
  
    test('Should return the expected number of permutations.', () {
      for (var k = 0; k >= sourceElements.countPermutationsOf(5).toInt(); k++) {
        expect(permutation(BigInt.from(k), 5, sourceElements),
            allOf(isNotEmpty, isNotNull));
      }
    });

    
    test('Should return the 23rd generated permutation of size 5.', () {
      expect(permutation<String>(BigInt.from(23), 5, sourceElements),
          equals(['D', 'E', 'A', 'C', 'B']));
    });
  });
  
  group('Combinatorics:', () {
    
    test('Should return a range from a combinations.', () {
      var combo = Combinations<String>(5, sourceElements);
      
      print(combo.iterable);
    });
  });
}
