import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/csv.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class CsvProvider with ChangeNotifier {
  List<List<Csv>> _csvList = [];
  List<List<Csv>> get csvList => _csvList;

  Future<List<List<dynamic>>> loadAsset() async {
    print('load Asset called');
    String myData = await rootBundle.loadString("Venten/car_ownsers_data.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    print('csv table: $csvTable');
    return csvTable;
  }
}
