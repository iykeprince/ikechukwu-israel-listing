import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:ikechukwu_israel/models/csv.dart';
import 'package:ikechukwu_israel/models/filter.dart';
import 'package:ikechukwu_israel/providers/data_provider.dart';
import 'package:ikechukwu_israel/utils/custom_helpers.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class CsvScreen extends StatefulWidget {
  static const String ROUTE_NAME = "/csv";
  CsvScreen({Key key}) : super(key: key);

  @override
  _CsvScreenState createState() => _CsvScreenState();
}

class _CsvScreenState extends State<CsvScreen> {
  ScrollController _scrollController;
  int _currentMax = 10;
  bool isLoadingAsset = false;
  List<Csv> _csvList = [];
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    print('scrolling...');
  }

  _getMoreData() {
    print('loading more data');
    for (int i = _currentMax; i < _currentMax + 10; i++) {}
  }

  @override
  Widget build(BuildContext context) {
    List<Csv> providerCsvList = Provider.of<List<Csv>>(context);
    _csvList = List.generate(_currentMax, (index) => providerCsvList[index]);
    print('waiting for csv to load: $_csvList');
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Car Owners',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          _csvList == null || _csvList.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _buildCsvList(context, _csvList)
        ],
      ),
    );
  }

  Widget _buildNotFiltered() {
    return Container(
      height: 320,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'No filter selected',
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCsvList(BuildContext context, List<Csv> csvList) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: csvList.length + 1,
      itemBuilder: (context, index) {
        if (index == csvList.length) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return _listItem(context, index, csvList);
      },
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
    );
  }

  _listItem(context, index, List<Csv> csvList) {
    Csv csv = csvList[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8.0,
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.grey,
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    '${csv.country}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Name',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${csv.first_name} ${csv.last_name}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${csv.email}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Color',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24.0,
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color:
                                        CustomHelpers.getColor(csv.car_color),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Text(
                                  '${csv.car_color}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Car Make',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${csv.car_model}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Year',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${csv.car_model_year}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${csv.gender}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Job Title',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${csv.job_title}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bio',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${csv.bio}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
