import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikechukwu_israel/models/csv.dart';
import 'package:ikechukwu_israel/models/filter.dart';
import 'package:ikechukwu_israel/providers/csv_provider.dart';
import 'package:ikechukwu_israel/providers/list_provider.dart';
import 'package:ikechukwu_israel/utils/custom_helpers.dart';
import 'package:ikechukwu_israel/utils/custom_shape_clipper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

List<Filter> filters = [];

class HomeScreen extends StatefulWidget {
  static const String ROUTE_NAME = "/home";
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedFilterIndex = -1;
  List<Csv> filteredList = [];
  PageController _pageController;

  loadAsset() async {
    String myData = await rootBundle.loadString("Venten/car_ownsers_data.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    List<Csv> csvList = listToMap(csvTable);
    setState(() {
      filteredList = csvList;
    });
  }

  List<Csv> listToMap(List<List<dynamic>> list) {
    List<Csv> csvList = [];
    for (int i = 1; i < list.length; i++) {
      Csv csv = Csv(
        id: list[i][0],
        first_name: list[i][1],
        last_name: list[i][2],
        email: list[i][3],
        country: list[i][4],
        car_model: list[i][5],
        car_model_year: list[i][6],
        car_color: list[i][7],
        gender: list[i][8],
        job_title: list[i][9],
        bio: list[i][10],
      );
      csvList.add(csv);
    }
    return csvList;
  }

  List<Csv> loadFilteredList(Filter selectedFilter) {
    print('loading new filters: $filteredList');
    List<Csv> newFilteredList = filteredList
        .where((filter) =>
            selectedFilter.startYear >= filter.car_model_year &&
            selectedFilter.endYear <= filter.car_model_year)
        .toList();
    print('new filteredList size: ${newFilteredList.length}');
    print('new filteredList: ${newFilteredList}');
    return newFilteredList;
  }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: .8);
    loadAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Filter>> filterFuture =
        context.select<ListingProvider, Future<List<Filter>>>(
            (value) => value.getListings());

    return Scaffold(
      body: FutureBuilder<List<Filter>>(
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
                                  SizedBox(height: 24),
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
                      _buildYearFilter(),
                      _buildCsvList(context, filteredList),
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

  _buildYearFilter() {
    List<Filter> nlist = filters;
    nlist.sort((a, b) => a.startYear.compareTo(b.startYear));
    return Container(
      height: 50.0,
      padding: EdgeInsets.only(left: 20.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: nlist.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedFilterIndex = index;
                    });
                  },
                  child: Container(
                      height: 40.0,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      margin: EdgeInsets.only(right: 4.0),
                      decoration: BoxDecoration(
                        color: selectedFilterIndex == index
                            ? Colors.black
                            : Colors.transparent,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${nlist[index].startYear} - ${nlist[index].endYear}',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: selectedFilterIndex == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
            ),
          ),
        ],
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
          filteredList = loadFilteredList(filters[selectedFilterIndex]);
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0,),
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

  Widget _buildCsvList(BuildContext context, filteredList) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 20.0,
      ),
      child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) => _listItem(context, index),
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }

  _listItem(context, index) {
    Csv csv = filteredList[index];
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Full Name'),
              Text('${csv.first_name} ${csv.last_name}'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Email'),
              Text('${csv.email}'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Country'),
              Text('${csv.country}'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Car Make, Color and Year'),
              Text('${csv.car_color}, ${csv.car_model} and ${csv.car_model_year}'),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Gender'),
              Text('${csv.gender}'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Job Title'),
              Text('${csv.job_title}'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Bio'),
              Text('${csv.bio}'),
            ],
          ),
        ],
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
