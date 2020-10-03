import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/csv.dart';
import 'package:ikechukwu_israel/models/filter.dart';
import 'package:ikechukwu_israel/providers/csv_provider.dart';
import 'package:ikechukwu_israel/providers/list_provider.dart';
import 'package:ikechukwu_israel/screens/csv_screen.dart';
import 'package:ikechukwu_israel/utils/custom_helpers.dart';
import 'package:ikechukwu_israel/utils/custom_shape_clipper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeScreen extends StatefulWidget {
  static const String ROUTE_NAME = "/home";
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  List<Filter> filters = [];
  int selectedFilterIndex = -1;
  List<Csv> _filteredList = [];

  @override
  void initState() {
    _pageController = PageController(viewportFraction: .8);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Filter>> filterFuture =
        context.select<ListingProvider, Future<List<Filter>>>(
            (value) => value.getListings());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: FutureBuilder<List<Filter>>(
                future: filterFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    filters = snapshot.data;
                    return SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                                        gradient: LinearGradient(colors: [
                                      Colors.deepOrange,
                                      Colors.orange
                                    ])),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 24.0,
                                        ),
                                        _buildHeader(),
                                        _buildListings(),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        _buildIndicator(context),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            _buildFilterBox(context),
//                            _buildCsvList(context, _filteredList),
//                          CsvScreen()
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
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
                    fontFamily: 'Signatra'),
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

  String _selectedYear;
  String _selectedGender;
  String _selectedCountry;
  String _selectedColor;

//  List<String> countries = ['ALL'];
//  List<String> colors = ['ALL'];


//  loadFilters(){
//    filters.forEach((element) {
//      Filter obj = element;
//      yearSet.add('${obj.startYear} - ${obj.endYear}');
//      obj.countries.forEach((country) {
//        countrySet.add(country);
//      });
//
//      obj.colors.forEach((color) {
//        colorSet.add(color);
//      });
//    });
//  }

  _buildFilterBox(BuildContext context) {

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
            child: Text(
              'Filter By',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButton(
                  items: context.watch<CsvProvider>().yearSet.toList().map((year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: FittedBox(
                        child: Text(year),
                      ),
                    );
                  }).toList(),
                  value: _selectedYear,
                  onChanged: (selectedYear) {
                    print('selected year: $selectedYear');
                    setState(() {
                      _selectedYear = selectedYear;
                    });
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
                  items: context.watch<CsvProvider>().genderSet.toList().map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (selectedGender) {
//                    List<Csv> filterGenderList = filterByGender(selectedGender);
//                    print('filter gender list: $filterGenderList');
                    print('gender $selectedGender');
                    setState(() {
                      _selectedGender = selectedGender;
                    });
                  },
                  value: _selectedGender,
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
                  items: context.watch<CsvProvider>().countrySet.toList().map((country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (selectedCountry) {
                    setState(() {
                      _selectedCountry = selectedCountry;
                    });
                  },
                  value: _selectedCountry,
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
                  items: context.watch<CsvProvider>().colorSet.toList().map((color) {
                    return DropdownMenuItem<String>(
                      value: color,
                      child: Text(color),
                    );
                  }).toList(),
                  onChanged: (selectedColor) {
                    setState(() {
                      _selectedColor = selectedColor;
                    });
                  },
                  value: _selectedColor,
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

  Widget _buildListings() {
    return Container(
      height: 200,
      child: PageView.builder(
        itemCount: filters.length,
        itemBuilder: (context, index) => _buildItem(context, index),
        controller: _pageController,
        onPageChanged: (value) {
          context.read<ListingProvider>().setPage(value);
        },
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var obj = filters[index];

    return InkWell(
      onTap: () {
        setState(() {
          selectedFilterIndex = index;
          print('selectedFilterIndex $index');
//          filteredList = loadFilteredList(filters[selectedFilterIndex]);
        });
      },
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
    int currentPage =
        context.select<ListingProvider, int>((value) => value.page);
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
            filters.length,
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
