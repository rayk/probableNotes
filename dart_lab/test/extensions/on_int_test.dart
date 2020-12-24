import 'package:test/test.dart';
import 'package:dart_lab/src/extensions/on_int.dart';

void main() {
  group('Factorial:', () {
    test('Should return 1 for 0!', () {
      expect(0.factorial, equals(1));
    });

    test('Should return 1 for 1!', () {
      expect(1.factorial, equals(1));
    });

    test('Should return 120 for 5!', () {
      expect(5.factorial, equals(120));
    });

    test('Should return 362,880 for 9!', () {
      expect(9.factorial, equals(362880));
    });

    test('Should return 3,628,800 for 10!', () {
      expect(10.factorial, equals(3628800));
    });

    test('Should return 39,916,800 for 11!', () {
      expect(11.factorial, equals(39916800));
    });

    test('Should return 479,001,600 for 12!', () {
      expect(12.factorial, equals(479001600));
    });

    test('Should return 6,227,020,800 for 13!', () {
      expect(13.factorial, equals(6227020800));
    });

    test('Should return 87,178,291,200 for 14!', () {
      expect(14.factorial, equals(87178291200));
    });

    test('Should return 1,307,674,368,000 for 15!', () {
      expect(15.factorial, equals(1307674368000));
    });

    test('Should return 20,922,789,888,000 for 16!', () {
      expect(16.factorial, equals(20922789888000));
    });

    test('Should return 355,687,428,096,000 for 17!', () {
      expect(17.factorial, equals(355687428096000));
    });

    test('should return 6,402,373,705,728,000 for 18!', () {
      expect(18.factorial, equals(6402373705728000));
    });

    test('Should return 121,645,100,408,832,000 for 19!', () {
      expect(19.factorial, equals(121645100408832000));
    });

    test('Should return 2,432,902,008,176,640,000 for 20!', () {
      expect(20.factorial, equals(2432902008176640000));
    });
    
    test('Should return approx 51,090,942,171,709,440,000 for 21!', () {
      print(22.factorial);
    });
  });
}
