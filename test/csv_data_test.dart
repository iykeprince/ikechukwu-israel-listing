import 'package:flutter_test/flutter_test.dart';
import 'package:ikechukwu_israel/providers/data_provider.dart';

void main() {
  group("Csv", () {
    test('Should return null', () {});
test('Should return dataset by year', () {
      int car_model_year = 2000;
      DataProvider().filterByYear(car_model_year);

      expect(DataProvider().csvList, greaterThanOrEqualTo(0));
    });
    test('Should return dataset by colors', () {
      String color = "Green";
      DataProvider().filterByColor(color);

      expect(DataProvider().csvList, greaterThanOrEqualTo(0));
    });
    test('Should return dataset by colors', () {
      String color = "Green";
      DataProvider().filterByColor(color);

      expect(DataProvider().csvList, greaterThanOrEqualTo(0));
    });
    test('Should return dataset by colors', () {
      String color = "Green";
      DataProvider().filterByColor(color);

      expect(DataProvider().csvList, greaterThanOrEqualTo(0));
    });

    
  });
}
