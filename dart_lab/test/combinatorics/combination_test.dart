import 'package:test/test.dart';
import 'package:dart_lab/src/combinatorics/combinations.dart';
import 'package:dart_lab/src/extensions/on_list.dart';

void main() {
    group('Combinations:', () {
      var members = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
      
      group('Combination of 4 from members.', () {
        var comb = Combinations(4, members);
        
        test('Should return a combination of the members.', () {
          expect(comb.toString(), isNotNull);
          expect(comb.count, equals(members.countCombinationsOf(4)));
          expect(comb.size, equals(4));
        });
        
        test('Should return combination at idx 5.', () {
          print(comb[5]);
        });
        
        
      
      });
    });
}