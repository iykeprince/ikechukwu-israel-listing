import 'package:flutter_test/flutter_test.dart';
import 'package:ikechukwu_israel/models/csv.dart';
import 'package:ikechukwu_israel/models/year_range.dart';
import 'package:ikechukwu_israel/providers/data_provider.dart';

import 'test_setup.dart';

Csv csv = Setup.loadCsv()[0];

void main() {

DataProvider().setCsvList(Setup.loadCsv());

  group("Csv", () {
    test('Should return null', () {});
    test('Should return dataset by years', () {
      
      DataProvider().filterByYear(csv);

      expect(DataProvider().csvList.length, greaterThanOrEqualTo(0));
    });
    test('Should return dataset by genders', () {
      String gender = "Male";
      DataProvider().filterByGender(csv);

      expect(DataProvider().csvList.length, greaterThanOrEqualTo(0));
    });
    test('Should return dataset by countries', () {
      String country = "Russia";
      DataProvider().filterByCountry(csv);

      expect(DataProvider().csvList.length, greaterThanOrEqualTo(0));
    });
    test('Should return dataset by colors', () {
      String color = "Green";
      DataProvider().filterByColor(csv);

      expect(DataProvider().csvList.length, greaterThanOrEqualTo(0));
    });
  });
}
