import 'package:ikechukwu_israel/models/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:ikechukwu_israel/utils/custom_helpers.dart';

class CsvProvider {
  List<Csv> list;
  

  Future<List<Csv>> loadCsv() async {
    String myData = await loadAsset();
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    list = CustomHelpers.listToMap(csvTable);
    return list;
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString("Venten/car_ownsers_data.csv");
  }
}
