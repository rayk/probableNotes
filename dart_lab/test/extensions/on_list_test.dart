import 'package:dart_lab/src/extensions/on_list.dart';
import 'package:test/test.dart';

void main() {
  var controlList = [
    "l68rde2",
    "XqA6E22f",
    "nUhI192",
    "Q5f0241",
    "8tWhiWh8",
    "v6p",
    "949ZQZve",
  ];

  group('Uniqueness:', () {
    var noItems = [];
    var uniqueItems = ['a', 'b', 'c', 'd'];
    var dupedItems = ['a', 'b', 'c', 'd', 'a', 'b', 'c', 'd'];

    test('Should return true that all items are unique.', () {
      expect(uniqueItems.isEachUnique, isTrue);
      expect(noItems.isEachUnique, isTrue);
    });

    test('Should return false that all items are not unique', () {
      expect(dupedItems.isEachUnique, isFalse);
    });
  });

  group('Contains every member:', () {
    var oneForOne = controlList;
    var someItems = ["l68rde2", "XqA6E22f", "nUhI192"];
    var allPlusMore = [
      "l68rde2",
      "XqA6E22f",
      "nUhI192",
      "Q5f0241",
      "8tWhiWh8",
      "v6p",
      "949ZQZve",
      "9qC0",
      "olj370",
      "1vd854",
      "nhF4",
      "fBU",
    ];

    test('Should return true when list has all items in the control.', () {
      expect(oneForOne.containsEveryItemIn(controlList), isTrue);
      expect(controlList.containsEveryItemIn(oneForOne), isTrue);
    });

    test('Should return false when only some item from the control exist.', () {
      expect(someItems.containsEveryItemIn(controlList), isFalse);
    });

    test('Should return false when no items from control exist.', () {
      expect([].containsEveryItemIn(controlList), isFalse);
    });

    test('Should return true when all control items exist plus more.', () {
      expect(allPlusMore.containsEveryItemIn(controlList), isTrue);
      expect(controlList.containsEveryItemIn(allPlusMore), isFalse);
    });
  });

  group('Combinations:', () {
    test('Should return number of combination using all items in list', () {
      expect(controlList.combinations, equals(BigInt.one));
      expect(controlList.combinations != controlList.permutations, isTrue);
    });

    test('Should return number of combination using 2 items from list.', () {
      expect(controlList.countCombinationsOf(2), equals(BigInt.from(21)));
    });

    test('Should return number of combination using 3 items from list.', () {
      expect(controlList.countCombinationsOf(3), equals(BigInt.from(35)));
    });

    test('Should return number of combinations using 4 items from list.', () {
      expect(controlList.countCombinationsOf(4), equals(BigInt.from(35)));
    });

    test('Should return number of combinations using 5 items form list.', () {
      expect(controlList.countCombinationsOf(5), equals(BigInt.from(21)));
    });

    test('Should return number of combinations using all items in list.', () {
      expect(controlList.countCombinationsOf(controlList.length),
          equals(controlList.combinations));
    });
  });

  group('Permutations:', () {
    test('Should return number of permutations using all items in list.', () {
      expect(controlList.permutations, equals(BigInt.from(5040)));
    });

    test('Should return number of permutations using 3 items from list.', () {
      expect(controlList.countPermutationsOf(3), equals(BigInt.from(210)));
    });

    test('Should return number of permutations using 4 items from list.', () {
      expect(controlList.countPermutationsOf(4), equals(BigInt.from(840)));
    });

    test('Should return number of permutations using 6 items from list.', () {
      expect(controlList.countPermutationsOf(6), equals(BigInt.from(5040)));
    });

    test('Should return same value from permutations as using all items.', () {
      expect(controlList.countPermutationsOf(controlList.length),
          equals(controlList.permutations));
    });
  });

  group('Operations on values:', () {
    var values = <int>[2, 38, 39, 27, 6, 12, 31, 28, 30, 23];
    var other = <bool>[true, false];
    
    test('Should return the smalled value in the list.', () {
      expect(values.min, equals(2));
    });
    
    test('Should return the largest values in the list.', () {
      expect(values.max, equals(39));
    });
    
    test('Should sum all the values in the list.', () {
      expect(values.sum, equals(236));
    });
    
    test('Should multiple each value in the list.', () {
      expect(values.product, equals(3450986622720));
    });
    
    test('Should return the median value in the list.', () {
      expect(values.median, equals(27.5));
    });
    
    test('Should return the mean value from the list.', () {
      expect(values.mean, equals(23.6));
    });
    
    test('Should return the variance of the value in the list.', () {
      expect(values.variance, equals(148.23999999999998));
    });
    
    test('Should return the standard deviation of the values in the list.', () {
      expect(values.standardDeviation, equals(12.175385004179539));
    });
  });
}
