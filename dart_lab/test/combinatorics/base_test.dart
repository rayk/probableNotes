import 'package:test/test.dart';
import 'package:dart_lab/src/combinatorics/_base.dart';
import 'package:dart_lab/src/extensions/on_list.dart';

void main() {
  test('Should return an idx key from an int.', () {
    expect(biIdxKey(5), equals(BigInt.from(5)));
  });

  test('Should return an adjusted idx to be inside the domain 0, n.', () {
    print(adjIdxKey(BigInt.from(100), BigInt.from(68)));
    expect(
        adjIdxKey(BigInt.from(100), BigInt.from(68)), equals(BigInt.from(32)));
  });

  test('Should return a list of all combinations.', () {
    var result = combination(BigInt.two, 4, [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
    ]);
    print(result);
  });
}
