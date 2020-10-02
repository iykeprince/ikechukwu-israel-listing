import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _singleton = ApiService();
  static ApiService get instance => _singleton;
  final String _baseUrl = 'https://ven10.co/';

  Future<dynamic> fetchData(String endpoint) async {
    final response = await http.get(_baseUrl + endpoint);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
