import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/csv_provider.dart';
import 'providers/data_provider.dart';
import 'providers/filter_provider.dart';
import 'screens/home_screen.dart';
import 'utils/custom_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
        FutureProvider(create: (_) => CsvProvider().loadCsv()),
        FutureProvider(create: (_) => FilterProvider().getFilters()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ikechukwu Israel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Raleway'),
      home: HomeScreen(),
      onGenerateRoute: CustomRouter.generateRoute,
    );
  }
}
