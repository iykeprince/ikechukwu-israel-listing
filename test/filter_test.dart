import 'dart:js_util';

import 'package:flutter_test/flutter_test.dart';
import 'package:ikechukwu_israel/models/filter.dart';
import '../lib/providers/filter_provider.dart';
import 'test_setup.dart';

void main() {
  group('Filter', () {
    test('empty value, should return empty list', () {
      FilterProvider().setFilters([]);

      expect(FilterProvider().filters.length, 0);
    });

    test('non-empty, should return list of filters', () {
      FilterProvider().setFilters(Setup.loadCsv());

      expect(FilterProvider().filters.length, greaterThan(1));
    });
  });
}
