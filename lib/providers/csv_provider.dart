import 'dart:io';

import 'package:ikechukwu_israel/models/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:ikechukwu_israel/utils/custom_exception.dart';
import 'package:ikechukwu_israel/utils/custom_helpers.dart';

class CsvProvider {
  List<Csv> list;

  Future<List<Csv>> loadCsv() async {
    try {
      String myData = await loadAsset();
      List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

      list = CustomHelpers.listToMap(csvTable);
      return list;
    } on CustomFileErrorException {
      return [];
    }
  }

  Future<String> loadAsset() async {
    try {
      return await rootBundle.loadString("Venten/car_ownsers_data.csv");
    } catch (e) {
      throw new CustomFileErrorException(e.message);
    }
  }
}
