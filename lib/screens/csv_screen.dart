import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:ikechukwu_israel/models/csv.dart';
import 'package:ikechukwu_israel/models/filter.dart';
import 'package:ikechukwu_israel/utils/custom_helpers.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class CsvScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/csv";
  var data = [];
  List<Csv> _filteredList = [];
  List<Csv> _csvList = [];
  PageController _pageController;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 10;
  bool isLoadingAsset = false;

  CsvScreen(){
    _scrollController.addListener(() {
      print('scrolled: ${_scrollController.position.maxScrollExtent}');
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getMoreData() {
    print('loading more data');
    for (int i = _currentMax; i < _currentMax + 10; i++) {
      _filteredList.add(_csvList[i]);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
          future: Future.value(['1','2']),
          builder: (context, snapshot) {
          return _buildCsvList(context);
        },),
    );
  }


  Widget _buildCsvList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 20.0,
      ),
      child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: _filteredList.length + 1,
          itemBuilder: (context, index) {
            if (index == _filteredList.length) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return _listItem(context, index);
          },
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }

  _listItem(context, index) {
    Csv csv = _filteredList[index];
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${index + 1}'),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Full Name'),
              Text('${csv.first_name} ${csv.last_name}'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email'),
              Text('${csv.email}'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Country'),
              Text('${csv.country}'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Car Make, Color and Year'),
              Text(
                  '${csv.car_color}, ${csv.car_model} and ${csv.car_model_year}'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gender'),
              Text('${csv.gender}'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Job Title'),
              Text('${csv.job_title}'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bio'),
              Text('${csv.bio}'),
            ],
          ),
        ],
      ),
    );
  }

}
