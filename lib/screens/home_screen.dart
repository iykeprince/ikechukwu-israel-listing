import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/csv.dart';
import 'package:ikechukwu_israel/models/filter.dart';
import 'package:ikechukwu_israel/models/year_range.dart';
import 'package:ikechukwu_israel/providers/data_provider.dart';
import 'package:ikechukwu_israel/providers/filter_provider.dart';
import 'package:ikechukwu_israel/utils/custom_helpers.dart';
import 'package:ikechukwu_israel/utils/custom_shape_clipper.dart';
import 'package:provider/provider.dart';

import 'csv_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/home";
  HomeScreen({Key key}) {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  List<Csv> providerCsvList;
  List<Filter> filters;
  DataProvider dataProvider;
  FilterProvider filterProvider;

  _scrollListener() {
    var isEnd = (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) &&
        !_scrollController.position.outOfRange &&
        (_scrollController.position.axisDirection == AxisDirection.down);

    if (isEnd) {
      _getMoreData();
    }
  }

  _getMoreData() {
    for (int i = dataProvider.currentMax;
        i < dataProvider.currentMax + 10;
        i++) {
      dataProvider.addCsvList(providerCsvList[i]);
    }

    dataProvider.currentMax += 10;
  }

  int selectedFilterIndex = -1;
  List<Csv> csvList = [];

  ScrollController _scrollController;

  initLoad() {
    if (providerCsvList != null) {
      print('providerCsvList: ${providerCsvList.length}');
      List.generate(dataProvider.currentMax,
          (index) => dataProvider.addCsvList(providerCsvList[index]));
    }
  }

  @override
  Widget build(BuildContext context) {
    providerCsvList = Provider.of<List<Csv>>(context, listen: true);
    dataProvider = Provider.of<DataProvider>(context, listen: false);
    filters = Provider.of<List<Filter>>(context, listen: false);
    filterProvider = Provider.of<FilterProvider>(context, listen: false);

    if (filters != null) {
      filterProvider.filters = filters;
    }

    Future.delayed(Duration.zero, () async => initLoad());
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white54,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: CustomShapeClipper(),
                        child: Container(
                          height: 400.0,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.deepOrange, Colors.orange])),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 24.0,
                              ),
                              _buildHeader(),
                              filters == null
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : FilterLayout(
                                      filters: filters,
                                    ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  filters == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : FilterBox(
                          filters: filters,
                        ),
                  CsvScreen(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          Expanded(
            child: Center(
              child: Text(
                'LISTINGS',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Signatra',
                  color: Colors.white,
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundImage: AssetImage("assets/backgrounds/avatar.png"),
          )
        ],
      ),
    );
  }
}

class FilterLayout extends StatefulWidget {
  final List<Filter> filters;
  const FilterLayout({Key key, this.filters}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<FilterLayout> {
  PageController _pageController = PageController(viewportFraction: .8);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildListings(),
        SizedBox(
          height: 20,
        ),
        _buildIndicator(context),
      ],
    );
  }

  Widget _buildListings() {
    return Container(
      height: 200,
      child: PageView.builder(
        itemCount: widget.filters.length,
        itemBuilder: (context, index) =>
            _buildItem(context, index, widget.filters),
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, filters) {
    Filter obj = filters[index];

    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 6.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(index >= filters.length
                ? CustomHelpers.backgrounds[filters.length % index]
                : CustomHelpers.backgrounds[index]),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          overflow: Overflow.clip,
          children: [
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromRGBO(0, 0, 0, .7),
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${obj.startYear}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 12,
                      height: 4,
                      margin: EdgeInsets.only(
                        top: 10.0,
                        left: 8,
                        right: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Text(
                      '${obj.endYear}',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 8.0,
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  obj.gender != ""
                      ? Text(
                          '${obj.gender.toUpperCase()}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "N/A",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ],
              )),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Center(
                child: Wrap(
                  children: obj.colors.map<Widget>((color) {
                    return _colorBox(color);
                  }).toList(),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 4,
              child: Container(
                width: 250.0,
                child: Wrap(
                  children: obj.countries.map<Widget>((country) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(color: Colors.black),
                      child: Text(
                        '$country',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 65.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            widget.filters.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.bounceInOut,
              margin: EdgeInsets.symmetric(
                horizontal: 1,
              ),
              width: currentPage == index ? 16 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentPage == index ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _colorBox(String color) {
    return Container(
      width: 24,
      height: 24,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: CustomHelpers.getColor(color), shape: BoxShape.circle),
      child: Text(
        '',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class FilterBox extends StatelessWidget {
  final List<Filter> filters;
  FilterBox({Key key, this.filters}) : super(key: key);

  DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    dataProvider = Provider.of<DataProvider>(context);

    filters.forEach((element) {
      Filter obj = element;
      YearRange yearRange = YearRange(
        startYear: obj.startYear,
        endYear: obj.endYear,
      );

      dataProvider.yearSet.add(yearRange);
      dataProvider.genderSet.add(obj.gender);
      obj.countries.forEach((country) {
        dataProvider.countrySet.add(country);
      });
      obj.colors.forEach((color) {
        dataProvider.colorSet.add(color);
      });
    });

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Filter By',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                dataProvider.isFiltered
                    ? RaisedButton.icon(
                        onPressed: () {
                          dataProvider.setSelectedYear(null);
                          dataProvider.setSelectedGender(null);
                          dataProvider.setSelectedCountry(null);
                          dataProvider.setSelectedColor(null);
                          dataProvider.isFiltered = false;
                        },
                        icon: Icon(Icons.clear, color: Colors.white,),
                        label: Text('Clear filter', style: TextStyle(color: Colors.white,),),
                        color: Colors.indigo,
                      )
                    : Container(),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButton(
                  items: dataProvider.yearSet.toList().map((yearRange) {
                    return DropdownMenuItem<YearRange>(
                      value: yearRange,
                      child: Text(
                        '${yearRange.startYear} - ${yearRange.endYear}',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    );
                  }).toList(),
                  value: dataProvider.selectedYear,
                  onChanged: (selectedYear) {
                    dataProvider.csvList.clear();
                    dataProvider.setSelectedYear(selectedYear);
                  },
                  isExpanded: false,
                  hint: Text(
                    'Year',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: DropdownButton(
                  items: dataProvider.genderSet.toList().map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (selectedGender) {
                    dataProvider.csvList.clear();
                    dataProvider.setSelectedGender(selectedGender);
                  },
                  value: dataProvider.selectedGender,
                  isExpanded: true,
                  hint: Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: DropdownButton(
                  items: dataProvider.countrySet.toList().map((country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (selectedCountry) {
                    dataProvider.csvList.clear();
                    dataProvider.setSelectedCountry(selectedCountry);
                  },
                  value: dataProvider.selectedCountry,
                  isExpanded: true,
                  hint: Text(
                    'Country',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: DropdownButton(
                  items: dataProvider.colorSet.toList().map((color) {
                    return DropdownMenuItem<String>(
                      value: color,
                      child: Text(color),
                    );
                  }).toList(),
                  onChanged: (selectedColor) {
                    dataProvider.csvList.clear();
                    dataProvider.setSelectedColor(selectedColor);
                  },
                  value: dataProvider.selectedColor,
                  isExpanded: true,
                  hint: Text(
                    'Color',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
