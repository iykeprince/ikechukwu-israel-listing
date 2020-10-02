import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class CsvScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/csv";
  CsvScreen({Key key}) : super(key: key);

  var data = [];
  Future<void> loadAsset() async {
    final myData = await rootBundle.loadString("Venten/car_ownsers_data.csv");

    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    data = csvTable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Table(
          children: data.map((item) {
            return TableRow(
              children: item.map((row) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    row.toString(),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      )
    );
  }
}
