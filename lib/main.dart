import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/csv_provider.dart';
import 'providers/list_provider.dart';
import 'screens/home_screen.dart';
import 'utils/custom_router.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ListingProvider()),
      ChangeNotifierProvider(create: (_) => CsvProvider()),
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
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      onGenerateRoute: CustomRouter.generateRoute,
    );
  }
}
