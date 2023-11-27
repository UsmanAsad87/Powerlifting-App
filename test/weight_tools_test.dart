import 'package:test/test.dart';
import 'package:powerlifting_app/utils/Utils.dart';

void main() {
  group("Pounds to Kilograms", () {
    test('calculates kilograms in 1 pound ', () {
      String Kilograms =
          converterTools.convert1("1", 0.0, 0.0).toStringAsFixed(3);
      expect(Kilograms, "0.454");
    });

    test('calculates kilograms in 10 pound ', () {
      String Kilograms =
          converterTools.convert1("10", 0.0, 0.0).toStringAsFixed(3);
      expect(Kilograms, "4.536");
    });

    test('Given an Argument Error using a zero', () {
      expect(() => converterTools.convert1("0", 0.0, 0.0), throwsArgumentError);
    });

    test('Given an Argument Error using a negative number', () {
      expect(
          () => converterTools.convert1("-5", 0.0, 0.0), throwsArgumentError);
    });
  });

  group("Kilograms to Pounds", () {
    test('calculates pounds in 1 kilogram ', () {
      String Pounds = converterTools.convert2("1", 0.0, 0.0).toStringAsFixed(3);
      expect(Pounds, "2.205");
    });

    test('calculates pounds in 10 kilograms ', () {
      String Pounds =
          converterTools.convert2("10", 0.0, 0.0).toStringAsFixed(3);
      expect(Pounds, "22.046");
    });

    test('Given an Argument Error using a zero', () {
      expect(() => converterTools.convert2("0", 0.0, 0.0), throwsArgumentError);
    });

    test('Given an Argument Error using a negative number', () {
      expect(
          () => converterTools.convert2("-5", 0.0, 0.0), throwsArgumentError);
    });
  });
}
